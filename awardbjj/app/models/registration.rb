class Registration < ApplicationRecord
  belongs_to :competitor, class_name: "User"
  belongs_to :bracket
end
