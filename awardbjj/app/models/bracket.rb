class Bracket < ApplicationRecord
  belongs_to :event

  has_one :weightclass, dependent: :destroy
  
  has_many :registrations, dependent: :destroy
  has_many :matches, dependent: :destroy  
end
