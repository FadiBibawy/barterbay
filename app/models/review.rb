class Review < ApplicationRecord
  # belongs_to :reviewer
  # belongs_to :rated_user

  belongs_to :reviewer, class_name: "User"
  belongs_to :rated_user, class_name: "User"
end
