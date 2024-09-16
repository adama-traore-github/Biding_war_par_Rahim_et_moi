class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|
      t.decimal :amount
      t.datetime :bid_date
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
