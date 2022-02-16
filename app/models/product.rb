class Product < ApplicationRecord
  belongs_to :subcategory
  has_many :cart_items
end
