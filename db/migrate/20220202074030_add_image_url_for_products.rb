class AddImageUrlForProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :image_url, :string
    add_column :products, :price, :integer
  end
end
