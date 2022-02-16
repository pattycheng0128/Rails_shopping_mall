class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  enum status: [:not_paid, :paid, :cancelled]

  def total_price
    order_items.reduce(0) {|sum, item| sum + item.price}
  end

end
