class SubcategoriesController < ProductsController
  before_action :get_category, only: [:products]
  before_action :get_subcategory, only: [:products]
  before_action :get_products, only: [:products]
  before_action :create_pagination, only: [:products]
  
  def products
  end

  private
  def get_category
    @category = Category.find(params[:category_id])
  end

  def get_subcategory
    @subcategory = Subcategory.find(params[:subcategory_id])
    # subcategory 後面的id必須和目前的 category id 一樣
    if @subcategory.category != @category
      redirect_to products_category_path
    end
  end

  # override products_controller
  def get_products
    @products = @subcategory.products
  end

end
