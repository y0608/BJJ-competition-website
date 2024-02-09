class User < ApplicationRecord
  # NOTE: should I use lockable to prevent brute force attacks??
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_presence_of :first_name, :last_name, if: :competitor?
  validates_presence_of :organization_name, if: :organizer?
  
  has_many :events, inverse_of: :organizer, dependent: :destroy
  has_many :entries, inverse_of: :competitor, dependent: :destroy

  enum role: { 
    organizer: 0, 
    competitor: 1
  }

  def full_name
    if role == "organizer"
      return organization_name
    else role == "competitor"
      return first_name+ " " + last_name
    end
  end
end