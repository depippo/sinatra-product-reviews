class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  has_many :user_products
end