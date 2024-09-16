class History < ApplicationRecord
    # Associations
    belongs_to :product
    belongs_to :user
  
    # Validations
    validates :bid_amount, :bid_date, presence: true
  end
  