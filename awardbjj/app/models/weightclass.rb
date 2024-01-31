class Weightclass < ApplicationRecord
	belongs_to :bracket
	
	scope :females, -> {where(sex: "female")}
	scope :males, -> {where(sex: "male")}
  
	scope :by_belt, -> belt {where(belt: belt)}
	scope :by_age, -> age {where(age: age)}
	scope :by_weight, -> weight {where(weight: weight)}
end
