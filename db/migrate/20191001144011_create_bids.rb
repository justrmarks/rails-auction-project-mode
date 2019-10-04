class CreateBids < ActiveRecord::Migration[6.0]
  def change
    create_table :bids do |t|
      t.integer :user_id
      t.integer :sale_id
      t.float :amount, :scale => 2

      t.timestamps
    end
  end
end
