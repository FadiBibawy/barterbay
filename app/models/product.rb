class Product < ApplicationRecord
  has_many_attached :photos

  belongs_to :user
  has_many :offers, dependent: :destroy
  # has_many :offered_products, class_name: 'Product', foreign_key: "offered_product_id"
  has_many :offered_offers, class_name: 'Offer', foreign_key: 'offered_product_id', dependent: :destroy
  validates :title, :description, :category, :quality, :photos, presence: true
end
