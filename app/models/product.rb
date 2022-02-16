class Product < ApplicationRecord
  belongs_to :subcategory
  has_many :cart_items
  has_many :order_items
end
