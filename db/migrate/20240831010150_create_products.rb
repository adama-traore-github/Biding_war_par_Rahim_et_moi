class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :category
      t.decimal :initial_price
      t.decimal :current_price
      t.datetime :auction_start_date
      t.datetime :auction_end_date
      t.string :image
      t.references :seller, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
