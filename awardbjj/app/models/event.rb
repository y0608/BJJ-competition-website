class Event < ApplicationRecord
  validates_presence_of :name, :location, :start_at, :end_at
  belongs_to :organizer, class_name: "User"
end