class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.text :message
      t.string :notification_type
      t.datetime :notification_date
      t.boolean :viewed

      t.timestamps
    end
  end
end
