class PaymentsController < ApplicationController
  before_action :get_order

  # 暫時取代金流
  def index
  end

  private
  def get_order
    @order = Order.find(params[:order_id])
    if !@order
      redirect_to products_path, notice: "沒有這個訂單"
    end
  end

end
