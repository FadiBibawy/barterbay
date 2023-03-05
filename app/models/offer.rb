class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :offered_product, class_name: "Product"

  after_destroy :reset_product_attributes


  validate :offered_product_cannot_be_same_as_product
  validate :unique_products_in_offers
  validate :same_owner
  validate :bartered_product

  def accept_or_refuse(status)
    if status == 'accept'
      self.accepted = true
      self.refused = false
    elsif status == 'refuse'
      self.accepted = false
      self.refused = true
    end
    self.deal = true
  end

  private

  def offered_product_cannot_be_same_as_product
    if product == offered_product
      errors.add(:offered_product, "cannot be the same as the product being offered")
    end
  end

  def unique_products_in_offers
    if Offer.exists?(product_id: product_id, offered_product_id: offered_product_id) ||
       Offer.exists?(product_id: offered_product_id, offered_product_id: product_id)
      errors.add(:base, "This offer already exists")
    end
  end

  def same_owner
    if product.user_id == offered_product.user_id
      errors.add(:base, "You can't barter with yourself!")
    end
  end

  def bartered_product
    if product.bartered? || (offered_product.present? && offered_product.bartered?)
      errors.add(:base, "Cannot make an offer on a product that has already been bartered.")
    end
  end

  def reset_product_attributes
    product.update(bartered: false)
    offered_product.update(bartered: false) if offered_product.present?
  end
end
