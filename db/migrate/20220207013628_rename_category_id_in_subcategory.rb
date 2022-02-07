class RenameCategoryIdInSubcategory < ActiveRecord::Migration[6.1]
  def change
    rename_column(:subcategories, :catogory_id, :category_id)
  end
end
