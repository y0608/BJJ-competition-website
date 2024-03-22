class Weightclass < ApplicationRecord
	belongs_to :bracket

	validates_presence_of :age, :belt, :sex, :weight

	# TODO: better validations, when people create custom weightclasses and when you add belt belts/ages.
	validates :age, inclusion: { in: %w(Juvenile Adult) }, length: { minimum: 1, maximum: 20 }
	validates :belt, inclusion: { in: %w(White Blue Purple Brown Black) }, length: { minimum: 1, maximum: 20 }
	validates :sex, inclusion: { in: %w(Male Female) }, length: { minimum: 1, maximum: 20 }
	validates :weight, numericality: { greater_than: 0 }

	scope :by_age, -> age {where(age: age)}
	scope :by_belt, -> belt {where(belt: belt)}
	scope :by_sex, -> sex {where(sex: sex)}
	scope :by_weight, -> weight {where(weight: weight)}
end