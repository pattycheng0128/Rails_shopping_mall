class PagesController < ApplicationController

  LIMIT_PRODUCT_NUMBER = 20

  def index
    @ad = {
      title: "廣告",
      description: "描述"
    }

    # 會去抓網址上面 page 的頁面數量(因為:page是從1開始,所以要減1),如果為 nil 會有問題
    # page = params[:page].to_i - 1
    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end

    @products = Product.all

    # 分頁功能
    @first_page = 1
    @last_page = (@products.count / LIMIT_PRODUCT_NUMBER)

    # 會覆寫掉 @products 內容
    @products = @products.offset((@page - 1) * LIMIT_PRODUCT_NUMBER).limit(LIMIT_PRODUCT_NUMBER)
  end
end
