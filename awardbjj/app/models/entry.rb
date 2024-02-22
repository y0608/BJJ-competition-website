class Entry < ApplicationRecord
  belongs_to :competitor, class_name: "User"
  belongs_to :bracket

  after_create_commit -> {
    broadcast_append_to "show_bracket_entries_#{self.bracket.id}", partial: "entries/entry", target: "bracket_entries_#{self.bracket.id}", locals: { entry: self }
  }
  after_destroy_commit -> {
    broadcast_remove_to "show_bracket_entries_#{self.bracket.id}", target: "bracket_entry_#{self.id}"
  }

  validate :uniqe_entry_for_competitor

  private

  def uniqe_entry_for_competitor
    if Entry.where(competitor: competitor, bracket_id: bracket).exists?
      errors.add(:competitor_id, 'can only register once for the event.')
    end
  end
end
