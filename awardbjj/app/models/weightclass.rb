class Weightclass < ApplicationRecord
	belongs_to :bracket
	
	scope :by_age, -> age {where(age: age)}
	scope :by_belt, -> belt {where(belt: belt)}
	scope :by_sex, -> sex {where(sex: sex)}
	scope :by_weight, -> weight {where(weight: weight)}
end