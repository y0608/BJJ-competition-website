class Event < ApplicationRecord
  after_create :create_brackets_and_weightclasses

  validates_presence_of :name, :start_at, :location, :game_type, :organizer_id
  
  enum game_type: { gi: 'Gi', no_gi: 'NoGi'}
  
  belongs_to :organizer, class_name: "User"
  has_many :brackets, dependent: :destroy
  has_many :registrations, through: :brackets
  # has_many :matches, through: :brackets

  private
    def create_brackets_and_weightclasses
      bracket = brackets.create() # automatically creates bracket ties it to an event
      weightclass = bracket.create_weightclass(age: "adult", sex: "male", belt: "white", weight: 77)
    end
end