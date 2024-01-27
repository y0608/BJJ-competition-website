class Event < ApplicationRecord
  validates_presence_of :name, :location, :start_at, :end_at
  
  enum game_type: { gi: 'Gi', no_gi: 'NoGi'}
  
  belongs_to :organizer, class_name: "User"

  has_many :brackets, dependent: :destroy

  has_many :registrations, through: :brackets
  # has_many :matches, through: :brackets
end