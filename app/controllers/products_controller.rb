class ProductsController < ApplicationController

  before_action :find_product, only:[:edit, :update, :destroy]
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

    @products = Product.all.order(:id)

    # 首頁類別/副類別
    @categories = Category.all

    # 分頁功能
    @first_page = 1
    count = @products.count
    @last_page = (count / LIMIT_PRODUCT_NUMBER)

    # 有餘數要多一頁
    if (count % LIMIT_PRODUCT_NUMBER)
      @last_page += 1
    end

    # 會覆寫掉 @products 內容
    @products = @products.offset((@page - 1) * LIMIT_PRODUCT_NUMBER).limit(LIMIT_PRODUCT_NUMBER)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(clean_params)
    if @product.save
      redirect_to products_path, notice: "新增成功"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.present?
      @product.update(clean_params)
      redirect_to products_path, notice: "更新成功"
      return
    else
      redirect_to products_path, notice: "更新失敗"
    end
  end

  def destroy
    if @product.present?
      @product.destroy
    end
    redirect_to products_path, notice: "刪除成功"
  end

  private
  def clean_params
    params.require(:product).permit(:name, :description, :image_url, :price, :subcategory_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end

end
