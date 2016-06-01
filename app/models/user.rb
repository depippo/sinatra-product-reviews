class User <ActiveRecord::Base
  has_many :reviews
  has_many :user_products
  has_many :products, through: :user_products
end
