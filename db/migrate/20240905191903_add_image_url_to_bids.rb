class AddImageUrlToBids < ActiveRecord::Migration[6.1]
  def change
    add_column :bids, :image_url, :string
  end
end
