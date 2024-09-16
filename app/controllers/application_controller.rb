class ApplicationController < ActionController::Base
  # Action qui s'exécute avant chaque requête pour configurer les paramètres autorisés
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Déclare 'active_class' comme méthode utilisable dans les vues
  helper_method :active_class

  # Méthode pour ajouter une classe 'active' aux éléments de navigation si le contrôleur et l'action actuels correspondent
  def active_class(controller_name, action_name = nil)
    if action_name
      # Vérifie si le contrôleur et l'action actuels correspondent à ceux passés en paramètres
      'active' if current_page?(controller: controller_name, action: action_name)
    else
      # Vérifie uniquement si le contrôleur actuel correspond à celui passé en paramètre
      'active' if controller_name == params[:controller]
    end
  end

  protected

  # Méthode pour configurer les paramètres supplémentaires autorisés par Devise lors de l'inscription et de la mise à jour du compte
  def configure_permitted_parameters
    # Permet à Devise d'accepter les paramètres :name, :email, :password, :password_confirmation et :role lors de l'inscription
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :role])

    # Permet à Devise d'accepter ces mêmes paramètres lors de la mise à jour du compte utilisateur
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :role])
  end
end
