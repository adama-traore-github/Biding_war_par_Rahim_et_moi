class Faq < ApplicationRecord
  # Associations
  belongs_to :user # Associe chaque FAQ à un utilisateur
  has_many :responses, class_name: 'Faq', foreign_key: 'parent_id', dependent: :destroy # Associe chaque FAQ aux réponses qui sont également des FAQ, en supprimant les réponses associées lorsqu'une FAQ est supprimée
  belongs_to :parent, class_name: 'Faq', optional: true # Associe chaque FAQ à une FAQ parent, si elle existe
  belongs_to :answered_by_user, class_name: 'User', optional: true # Associe chaque FAQ à un utilisateur ayant répondu, si cela existe

  # Définition des rôles possibles pour la FAQ
  enum role: { buyer: 0, seller: 1, both: 2 }

  # Validation
  validates :question, presence: true, if: -> { parent.nil? } # Valide que la question est présente si la FAQ n'a pas de parent
  validates :role, presence: true # Valide que le rôle est présent

  # Méthode pour vérifier si un utilisateur peut répondre à une FAQ
  def can_respond?(current_user)
    # Un utilisateur avec le rôle "both" peut répondre à toutes les questions de la FAQ avec le rôle "both"
    if current_user.role == 'both'
      role == 'both'
    else
      role == current_user.role # Vérifie si le rôle de la FAQ correspond au rôle de l'utilisateur
    end
  end
end
