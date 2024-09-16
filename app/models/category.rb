class Category < ApplicationRecord
  # Associations
  has_many :products

  VALID_CATEGORIES = ['Art', 'Beauté', 'Trésors', 'Games']

  # Validations
  validates :name, presence: true, uniqueness: true, inclusion: { in: VALID_CATEGORIES, message: "doit être parmi les suivantes: #{VALID_CATEGORIES.join(', ')}" }
end
