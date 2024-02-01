class Registration < ApplicationRecord
  belongs_to :competitor, class_name: "User"
  belongs_to :bracket

  # validate :uniqe_registration_for_competitor

  private

  # def unique_registration_per_bracket_and_competitor

  #   if Registration.where(competitor: competitor, bracket_id: bracket).exists?
  #   errors.add(:competitor_id, 'Competitor can only register once for the event.')
  # end

end
