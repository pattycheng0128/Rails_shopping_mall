# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = [
  {
    "name": "3C",
    "subcategories": [
      "電腦",
      "手機",
      "家電",
      "相機"
    ]
  },
  {
    "name": "美食",
    "subcategories": [
      "飲品",
      "零食",
      "泡麵",
      "麵包"
    ]
  }
]

categories.each do |c_data|
  category = Category.create(name: c_data[:name]) 
  c_data[:subcategories].each do |s_data_name|
    subcategory = Subcategory.create(name: s_data_name, category: category)
  end 
end

# 將抓到的 subcategory 內容放到底下 product 裡面
subcategory = Subcategory.all[4]

PRODUCT_COUNT = 100

(1..PRODUCT_COUNT).each do |index|
  product = {
    name: "馬卡龍",
    description: "好吃",
    image_url: "https://images.pexels.com/photos/239581/pexels-photo-239581.jpeg",
    price: 300,
    subcategory: subcategory
}

Product.create(product)
end