class OrdersController < ApplicationController

  before_action :authenticate!
  before_action :get_order, only: [:show, :update, :destroy]

  def index
    #顯示使用者的所有訂單
    @orders = current_user.orders
  end

  def show
    #看到某個訂單的細節
    @order_items = @order.order_items
  end

  def create
    #建立某個訂單,狀態是還沒付款
    if current_user.buy_now_cart_items.count == 0
      redirect_to cart_items_path, notice: "沒有商品"
      return
    end
    
    @order = Order.not_paid.create(
      user: current_user,
      user_name: current_user.name
    )

    current_user.buy_now_cart_items.each do |cart_item|
      begin
        OrderItem.create!(
        order: @order,
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.price
        )
      rescue
        @order.order_items.destroy_all
        @order.destroy

        redirect_to products_path, notice: "訂單建立失敗"
        return
      end
    end

    current_user.buy_now_cart_items.destroy_all
    redirect_to payments_path(order_id: @order.id), notice: "訂單建立成功"
  end

  def update
    #更新訂單狀態,狀態是已經付款
    if params[:payment_method] == "credit_card"
      @order.paid!
      redirect_to products_path, notice: "訂單已付款"
      return
    else
      redirect_to products_path, notice: "訂單待付款"
    end
  end

  def destroy
    #訂單不會被真的刪除,所以是更新一個訂單,狀態是已取消
  end

  private
  def get_order
    @order = Order.find(params[:id])
    if !@order
      redirect_to products_path, notice: "Can't find order"
    end
  end

end
