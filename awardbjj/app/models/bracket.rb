class Bracket < ApplicationRecord
  belongs_to :event

  has_one :weightclass, dependent: :destroy
  
  has_many :registrations, dependent: :destroy
  has_many :matches, dependent: :destroy  

  scope :has_registrations, -> {
    joins(:registrations)
      .group('brackets.id')
      .having('COUNT(registrations.id) > 0')
  }


end
