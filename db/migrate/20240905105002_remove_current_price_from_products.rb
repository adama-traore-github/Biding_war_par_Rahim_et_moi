class RemoveCurrentPriceFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :current_price, :decimal
  end
end
