class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.integer :status
      t.string :user_name
      t.string :user_phone
      t.string :user_address
      t.timestamps
    end
  end
end
