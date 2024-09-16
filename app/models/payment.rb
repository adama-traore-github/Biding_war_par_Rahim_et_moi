class Payment < ApplicationRecord
    # Associations
    belongs_to :user
    belongs_to :product
  
    # Validations
    validates :amount, :payment_date, :payment_method, :status, presence: true
  end
  