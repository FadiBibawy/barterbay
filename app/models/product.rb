class Product < ApplicationRecord
  belongs_to :user
  has_many :offers
  has_many :offer_products, class_name: 'Product', foreign_key: "offered_product_id"
end
