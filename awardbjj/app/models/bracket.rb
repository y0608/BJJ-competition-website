class Bracket < ApplicationRecord
  belongs_to :event

  has_one :weightclass, dependent: :destroy
  
  has_many :entries, dependent: :destroy
  has_many :matches, dependent: :destroy  

  scope :has_entries, -> {
    joins(:entries).where.not(entries: { id: nil})
  }

  scope :with_weightclass, ->(options = {}) {
    joins(:weightclass)
      .merge( options[:age].present?    ? Weightclass.by_age(options[:age])       : Weightclass.all)
      .merge( options[:belt].present?   ? Weightclass.by_belt(options[:belt])     : Weightclass.all)
      .merge( options[:weight].present? ? Weightclass.by_weight(options[:weight]) : Weightclass.all)
      .merge( options[:sex].present?    ? Weightclass.by_sex(options[:sex])       : Weightclass.all)
      .distinct
  }

  def create_matches
    #TODO: should return false if there are is an error
    players_count = entries.size

    if players_count <= 0
      return true
    end

    rounds_count = Math.log2(players_count).ceil
	  byes_count = 2 ** rounds_count - players_count

    entries_with_byes = entries.to_a
    # insert byes
    if byes_count > 0
    	entries_with_byes = insert_byes(entries_with_byes, byes_count)
    end

    # make rounds
    previous_matches = []
    (0..(rounds_count-1)).each do |round_number|
      matches_in_round = 2**round_number

      current_matches = []
      (0..(matches_in_round-1)).each do |match_index|
        if round_number == rounds_count - 1
          new_match = matches.create(
            competitor1: entries_with_byes[match_index * 2] ? entries_with_byes[match_index * 2].competitor : nil,
            competitor2: entries_with_byes[match_index * 2 + 1] ? entries_with_byes[match_index * 2 + 1].competitor : nil,
            round: round_number,
            next_match: previous_matches[match_index / 2] # nil if match_index == 0
          )
        else
          new_match = matches.create(
            competitor1: nil,
            competitor2: nil,
            round: round_number,
            next_match: previous_matches[match_index / 2]
          )
        end
        current_matches.push(new_match)
      end
      previous_matches = current_matches
    end
  end

  private
  def insert_byes(entries, byes_count)
    players_count = entries.size
  
    if byes_count <= 1
      entries.insert(players_count, nil)
      return entries
    elsif players_count <= 1
      return entries
    end
  
    byes_upper = (byes_count / 2).ceil
    byes_lower = byes_count - byes_upper
  
    upper_half = entries[0..(players_count/2 - 1)]
    lower_half = entries[(players_count/2)..-1]
  
    upper_half = insert_byes(upper_half, byes_upper)
    lower_half = insert_byes(lower_half, byes_lower)
  
    return upper_half + lower_half
  end
end
