class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.decimal :amount
      t.datetime :payment_date
      t.string :payment_method
      t.string :status

      t.timestamps
    end
  end
end
