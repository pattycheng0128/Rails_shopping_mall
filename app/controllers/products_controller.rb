class ProductsController < ApplicationController

  before_action :if_not_admin, only: [:new, :edit, :update, :destroy]
  before_action :find_product, only:[:edit, :update, :show, :destroy]
  before_action :prepare_index, only: [:index,:show, :products]
  before_action :get_products, only: [:index, :products]
  before_action :create_pagination, only: [:index, :products]

  LIMIT_PRODUCT_NUMBER = 20

  def index
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
    # [:image] 對到 view
    image = params[:product][:image]

    if image
      image_url = save_file(image)
      @product.update(clean_params.merge(image_url: image_url))
    else
      @product.update(clean_params)
    end
    redirect_to products_path, notice: "更新成功"
  end

  def show
  end

  def destroy
    if @product.present?
      @product.destroy
    end
    redirect_to products_path, notice: "刪除成功"
  end

  private
  def clean_params
    params.require(:product).permit(:name, :description, :price, :subcategory_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def if_not_admin
    if !current_user.is_admin
      redirect_to products_path, notice:"您沒有權限"
    end
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

  def prepare_index
    create_ad
    get_current_page
    get_all_categories
  end

  def create_ad
    @ad = {
      title: "廣告",
      description: "描述"
    }
  end

  def get_current_page
    # 會去抓網址上面 page 的頁面數量(因為:page是從1開始,所以要減1),如果為 nil 會有問題
    # page = params[:page].to_i - 1
    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end
  end

  def get_all_categories
    # 首頁類別/副類別
    @categories = Category.all
  end

  def get_products
    # @products = Product.all.order(:id)
    @q = Product.all.order(:id).ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def create_pagination
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

end
