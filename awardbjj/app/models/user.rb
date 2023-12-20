class User < ApplicationRecord
  # NOTE: should I use lockable to prevent brute force attacks??
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  has_many :events, inverse_of: :organizer, dependent: :destroy

  enum role: { 
    organizer: 0, 
    competitor: 1
  }

  validates_presence_of :first_name, :last_name, if: :competitor?
  validates_presence_of :organization_name, if: :organizer?

  def full_name
    if role == "organizer"
      return organization_name
    else role == "competitor"
      return first_name+ " " + last_name
    end
  end

  def organizer?
    role == "organizer"
  end

  def competitor?
    role == "competitor"
  end
end