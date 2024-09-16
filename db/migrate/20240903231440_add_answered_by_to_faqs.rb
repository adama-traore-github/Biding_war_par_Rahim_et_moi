class AddAnsweredByToFaqs < ActiveRecord::Migration[6.1]
  def change
    add_column :faqs, :answered_by_user_id, :integer
  end
end
