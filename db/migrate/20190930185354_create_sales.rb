class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :buyer_id, null: true
      t.float :price
      t.string :name
      t.string :description
      t.datetime :closing_date

      t.timestamps
    end
  end
end
