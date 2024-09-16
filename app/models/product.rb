class Product < ApplicationRecord
  # Associations
  # Un produit appartient à un vendeur (utilisateur) et à une catégorie.
  # Il peut avoir une image attachée et plusieurs enchères associées.
  belongs_to :seller, class_name: 'User'
  belongs_to :category
  has_one_attached :image
  has_many :bids, dependent: :destroy

  # Méthode pour obtenir la plus haute enchère d'un produit.
  def highest_bid
    bids.order(amount: :desc).first
  end

  # Méthode pour obtenir le prix actuel du produit (soit la plus haute enchère, soit le prix initial).
  def current_price
    highest_bid ? highest_bid.amount : initial_price
  end

  # Méthode qui vérifie si l'enchère est terminée en comparant la date de fin avec l'heure actuelle.
  def auction_ended?
    auction_end_date < Time.current
  end

  # Validations
  # Validation de la présence du nom du produit, de la catégorie et de l'image.
  # Validation que le prix initial est un nombre supérieur ou égal à 1.
  validates :name, presence: true
  validates :initial_price, numericality: { greater_than_or_equal_to: 1 }
  validates :image, presence: { message: "doit être fourni." }
  validates :category_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # Appel d'une méthode personnalisée pour valider les dates de début et de fin de l'enchère.
  validate :valid_dates

  # Méthode pour obtenir l'URL de l'image associée, ou nil si aucune image n'est attachée.
  def image_url
    image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) : nil
  end

  private

  # Méthode privée pour valider les dates de début et de fin de l'enchère.
  def valid_dates
    # Vérification que la date de début n'est pas dans le passé.
    if auction_start_date.present? && auction_start_date < Date.today
      errors.add(:auction_start_date, "ne peut pas être dans le passé.")
    end

    # Vérification que la date de fin est après la date de début, si elle est fournie.
    if auction_end_date.present? && auction_start_date.present? && auction_end_date <= auction_start_date
      errors.add(:auction_end_date, "doit être après la date de début.")
    end
  end
end
