class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :offered_product, class_name: "Product"

  validate :offered_product_cannot_be_same_as_product
  validate :unique_products_in_offers

  def accept_or_refuse(status)
    if status == 'accept'
      self.accepted = true
      self.refused = false
    elsif status == 'refuse'
      self.accepted = false
      self.refused = true
    end
    self.save
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
end
