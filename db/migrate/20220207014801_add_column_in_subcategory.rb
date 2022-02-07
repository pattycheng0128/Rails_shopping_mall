class AddColumnInSubcategory < ActiveRecord::Migration[6.1]
  def change
    add_reference(:subcategories, :category)
  end
end
