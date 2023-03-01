class Review < ApplicationRecord
  # belongs_to :reviewer
  # belongs_to :rated_user

  belongs_to :reviewer, class_name: "User"
  belongs_to :rated_user, class_name: "User"

  validates :content, presence: true
  validates :rating, numericality: { less_than_or_equal_to: 5 }
end
