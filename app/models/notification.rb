class Notification < ApplicationRecord
    # Associations
    belongs_to :user
  
    # Validations
    validates :message, :notification_type, :notification_date, presence: true
  end
  