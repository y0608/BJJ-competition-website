class Bracket < ApplicationRecord
  belongs_to :event

  has_one :weightclass, dependent: :destroy
  
  has_many :registrations, dependent: :destroy
  has_many :matches, dependent: :destroy  

  scope :has_registrations, -> {
    joins(:registrations).where.not(registrations: { id: nil})
  }

  scope :with_weightclass, ->(options = {}) {
    joins(:weightclass)
      .merge( options[:age].present?    ? Weightclass.by_age(options[:age])       : Weightclass.all)
      .merge( options[:belt].present?   ? Weightclass.by_belt(options[:belt])     : Weightclass.all)
      .merge( options[:weight].present? ? Weightclass.by_weight(options[:weight]) : Weightclass.all)
      .merge( options[:sex].present?    ? Weightclass.where(sex: options[:sex])   : Weightclass.all)
      .distinct
  }

  # private
  def create_matches
    (0..registrations.count-1).step(2).each do |i|
      matches.create!(
        competitor1: registrations[i], 
        # competitor2: registrations[i+1].nil? ? nil : registrations[i+1]
        competitor2: nil
      )
    end
  end

end
