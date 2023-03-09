class Product < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?



  has_many_attached :photos

  belongs_to :user
  has_many :offers, dependent: :destroy
  # has_many :offered_products, class_name: 'Product', foreign_key: "offered_product_id"
  has_many :offered_offers, class_name: 'Offer', foreign_key: 'offered_product_id', dependent: :destroy

  validates :title, :description, :quality, presence: true

  include PgSearch::Model
  pg_search_scope :search,
                  against: [:title, :description, :category],
                  using: {
                    tsearch: { prefix: true }
                  }
end
