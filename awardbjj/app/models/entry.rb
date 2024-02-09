class Entry < ApplicationRecord
  belongs_to :competitor, class_name: "User"
  belongs_to :bracket

  validate :uniqe_entry_for_competitor

  private

  def uniqe_entry_for_competitor
    if Entry.where(competitor: competitor, bracket_id: bracket).exists?
      errors.add(:competitor_id, 'can only register once for the event.')
    end
  end
end
