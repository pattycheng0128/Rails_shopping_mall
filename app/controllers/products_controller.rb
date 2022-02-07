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
    image = params[:product][:image]
    if image
      image_url = save_file(image)
    end

    product = Product.create(clean_params.merge(image_url: image_url))
    redirect_to products_path, notice: "新增成功"
  end

  def edit
  end

  def update
    # 為什麼可以用:image?
    image = params[:product][:image]

    if image
      image_url = save_file(image)
      @product.update(clean_params.merge(image_url: image_url))
    else
      @product.update(clean_params)
    end
    redirect_to products_path, notice: "更新成功"
  end

  def destroy
    if @product.present?
      @product.destroy
    end
    redirect_to products_path, notice: "刪除成功"
  end

  def save_file(newFile)
    dir_url = Rails.root.join('public', 'uploads/products')
    FileUtils.mkdir_p(dir_url) unless File.directory?(dir_url)

    file_url = dir_url + newFile.original_filename

    File.open(file_url, 'w+b') do |file|
      file.write(newFile.read)
    end

    return '/uploads/products/' + newFile.original_filename
  end

  private
  def clean_params
    params.require(:product).permit(:name, :description, :price, :subcategory_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end

end
