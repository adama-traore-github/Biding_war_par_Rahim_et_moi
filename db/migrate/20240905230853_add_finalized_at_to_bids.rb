class AddFinalizedAtToBids < ActiveRecord::Migration[6.1]
  def change
    add_column :bids, :finalized_at, :datetime
  end
end
