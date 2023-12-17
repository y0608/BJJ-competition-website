class User < ApplicationRecord
  # NOTE: should I use lockable to prevent brute force attacks??
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum role: { 
    organizer: 0, 
    competitor: 1
  }

  validates :role, presence: true
  validates_presence_of :first_name, :last_name, if: :competitor?
  validates_presence_of :organization_name, if: :organizer?

  def organizer?
    role == "organizer"
  end

  def competitor?
    role == "competitor"
  end
end