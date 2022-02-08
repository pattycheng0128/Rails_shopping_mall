class Category < ApplicationRecord
  has_many :subcategories
  # 可以直接在 controller 使用 products 方法
  has_many :products, through: :subcategories
end
