class CreateSubcategories < ActiveRecord::Migration[6.1]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.belongs_to :catogory
      t.timestamps
    end
  end
end
