class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  # Associations
  has_many :products, foreign_key: :seller_id
  has_many :bids
  has_many :histories
  has_many :payments
  has_many :reviews
  has_many :notifications
  has_many :faqs, dependent: :destroy

  # Enum for role
  enum role: { buyer: 0, seller: 1, both: 2 }

  # Method to return the display name
  def display_name
    name.presence || "Utilisateur anonyme"
  end

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true # Assurer que le rôle est présent

  
  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
