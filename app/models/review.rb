class Review < ApplicationRecord
    # Associations
    belongs_to :product
    belongs_to :user
  
    # Validations
    validates :rating, presence: true
    validates :comment, presence: true
  end
  