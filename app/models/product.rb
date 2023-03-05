class Product < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model

  has_many_attached :photos

  belongs_to :user
  has_many :offers, dependent: :destroy
  # has_many :offered_products, class_name: 'Product', foreign_key: "offered_product_id"
  has_many :offered_offers, class_name: 'Offer', foreign_key: 'offered_product_id', dependent: :destroy

  validates :title, :description, :category, :quality, presence: true

  pg_search_scope :search_by_title,
                  against: [:title],
                  using: {
  tsearch: { prefix: true }
  }
end
