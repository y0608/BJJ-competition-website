class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  enum role: {
    organizer: 0,
    competitor: 1
  }

  validates_presence_of :role
  validates :role, inclusion: { in: roles.keys }

  validates_presence_of :first_name, :last_name, if: :competitor?
  validates_presence_of :organization_name, if: :organizer?

  validates :first_name, length: { minimum: 1, maximum: 50 }, if: :competitor?
  validates :last_name, length: { minimum: 1, maximum: 50 }, if: :competitor?
  validates :organization_name, length: { minimum: 1, maximum: 50 }, if: :organizer?

  has_many :events, inverse_of: :organizer, dependent: :destroy
  has_many :entries, inverse_of: :competitor, dependent: :destroy


  def full_name
    if role == "organizer"
      return organization_name
    else role == "competitor"
      return first_name+ " " + last_name
    end
  end
end