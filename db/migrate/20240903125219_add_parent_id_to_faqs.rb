class AddParentIdToFaqs < ActiveRecord::Migration[6.1]
  def change
    add_column :faqs, :parent_id, :bigint
  end
end
