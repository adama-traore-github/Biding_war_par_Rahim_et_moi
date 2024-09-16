class AddEndTimeToBids < ActiveRecord::Migration[6.1]
  def change
    add_column :bids, :end_time, :datetime
  end
end
