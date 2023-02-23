class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :offered_product, class_name: "Product"
end
