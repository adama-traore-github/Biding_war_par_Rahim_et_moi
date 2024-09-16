class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.decimal :bid_amount
      t.datetime :bid_date

      t.timestamps
    end
  end
end
