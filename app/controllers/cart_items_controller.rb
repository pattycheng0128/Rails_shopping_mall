class CartItemsController < ApplicationController

  before_action :authenticate!
  before_action :get_cart, except: [:index, :destroy]
  before_action :get_cart_item, only: [:destroy]

  def index
    @buy_now_items = current_user.buy_now_cart_items
    @total_price = current_user.buy_now_cart.total_price
  end

  def create
    product = Product.find(params[:product_id])
    if product
      CartItem.create(product: product, quantity: 1, cart: @cart)  # @cart底下的實體變數
      redirect_to cart_items_path, notice: "加入購物車成功"
      return
    else
      redirect_to courses_path, notice: "加入購物車失敗"
    end
  end

  def destroy
    if @cart_item.present?
      @cart_item.destroy
      redirect_to cart_items_path, notice: "刪除成功"
    end
  end

  private
  def get_cart
    # params 是給 view cart_type 用的
    @cart = current_user.carts.find_by(cart_type: params[:cart_type])
    if !@cart
      redirect_to cart_items_path, notice: "Can't find cart"
    end
  end

  def get_cart_item
    @cart_item = CartItem.find(params[:id])
    if !@cart_item
      redirect_to cart_items_path, notice: "Can't find cart item"
    end
  end

  
end
