class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :offered_product, class_name: "Product"
  has_many :messages, dependent: :destroy


  after_destroy :reset_product_attributes


  validate :offered_product_cannot_be_same_as_product
  validate :unique_products_in_offers
  validate :same_owner
  validate :bartered_product

  def accept_or_refuse(status)
    if status == 'accept'
      self.accepted = true
      self.refused = false
      self.deal = true
    elsif status == 'refuse'
      self.accepted = false
      self.refused = true
    end
  end

  private

  #add a validation to prevent offering the same product with itself
  def offered_product_cannot_be_same_as_product
    if product == offered_product
      errors.add(:offered_product, "cannot be the same as the product being offered")
    end
  end

  #add a validation to prevent offer the same previous offer that has the same offered products
  def unique_products_in_offers
    if Offer.exists?(product_id: product_id, offered_product_id: offered_product_id) ||
       Offer.exists?(product_id: offered_product_id, offered_product_id: product_id)
      errors.add(:base, "This offer already exists")
    end
  end

  #add a validation to prevent the same user to barter with 2 products that he owns
  def same_owner
    if product.user_id == offered_product.user_id
      errors.add(:base, "You can't barter with yourself!")
    end
  end

  #add a validation to prevent an already bartered product ( has an accepted offer) to be offered again
  def bartered_product
    if product.bartered? || (offered_product.present? && offered_product.bartered?)
      errors.add(:base, "Cannot make an offer on a product that has already been bartered.")
    end
  end

  #reset the 'bartered' attribute of a product to false if its accepted offer is deleted
  def reset_product_attributes
    product.update(bartered: false)
    offered_product.update(bartered: false) if offered_product.present?
  end
end
