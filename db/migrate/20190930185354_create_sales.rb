class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.integer :seller_id, null: false
      t.integer :buyer_id, null: true
      t.float :price
      t.string :name
      t.string :description
      t.datetime :closing_date
      t.boolean :active

      t.timestamps
    end
  end
end
