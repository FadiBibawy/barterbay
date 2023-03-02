class User < ApplicationRecord
  has_one_attached :photo, dependent: :destroy

  has_many :products, dependent: :destroy
  has_many :offers, dependent: :destroy

  has_many :reviews, foreign_key: :reviewer_id, dependent: :destroy
  has_many :rated_reviews, class_name: "Review", foreign_key: :rated_user_id, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :username, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def name
    "#{first_name} #{last_name}"
  end
end
