class FaqsController < ApplicationController
  before_action :authenticate_user! # Assure que l'utilisateur est authentifié avant d'accéder aux actions

  def index
    @faq = Faq.new # Crée une nouvelle instance de FAQ pour le formulaire
    @faqs = case current_user.role
            when 'seller'
              # Récupère les FAQs pour les vendeurs correspondant à l'utilisateur actuel
              Faq.where(role: 'seller', user_id: current_user.id)
            when 'buyer'
              # Récupère les FAQs pour les acheteurs correspondant à l'utilisateur actuel
              Faq.where(role: 'buyer', user_id: current_user.id)
            when 'both'
              # Récupère les FAQs pour les rôles 'both', triées par date de création décroissante
              Faq.where(role: 'both', user_id: Faq.where(role: 'both').pluck(:user_id)).order(created_at: :desc)
            else
              Faq.none # Aucun FAQ si le rôle ne correspond pas
            end
  end

  def seller
    authorize_role('seller') do
      # Récupère les FAQs pour les vendeurs triées par date de création décroissante
      @faqs = Faq.where(role: 'seller').order(created_at: :desc)
      @faq = Faq.new # Crée une nouvelle instance de FAQ pour le formulaire
    end
  end

  def buyer
    authorize_role('buyer') do
      # Récupère les FAQs pour les acheteurs triées par date de création décroissante
      @faqs = Faq.where(role: 'buyer').order(created_at: :desc)
      @faq = Faq.new # Crée une nouvelle instance de FAQ pour le formulaire
    end
  end

  def both
    authorize_role('both') do
      # Récupère les FAQs pour les rôles 'both', triées par date de création décroissante
      @faqs = Faq.where(role: 'both', user_id: Faq.where(role: 'both').pluck(:user_id)).order(created_at: :desc)
      @faq = Faq.new # Crée une nouvelle instance de FAQ pour le formulaire
    end
  end

  def create
    Rails.logger.debug "Params: #{params.inspect}" # Journalise les paramètres reçus
    @faq = Faq.new(faq_params) # Crée une nouvelle FAQ avec les paramètres fournis
    @faq.role = current_user.role # Assigne le rôle de l'utilisateur actuel à la FAQ
    @faq.user = current_user # Assigne l'utilisateur actuel comme propriétaire de la FAQ
  
    if @faq.save # Tente de sauvegarder la FAQ
      Rails.logger.debug "FAQ saved: #{@faq.inspect}" # Journalise la FAQ sauvegardée
      redirect_to request.referer || faqs_path, notice: 'Question posée avec succès.' # Redirection avec un message de succès
    else
      Rails.logger.debug "FAQ not saved: #{@faq.errors.full_messages.join(", ")}" # Journalise les erreurs de sauvegarde
      @faqs = Faq.where(role: current_user.role) # Récupère les FAQs pour le rôle de l'utilisateur actuel
      render :index # Rendu de la vue index avec les erreurs
    end
  end

  def update
    @faq = Faq.find(params[:id]) # Trouve la FAQ par son ID
    if @faq.can_respond?(current_user) && @faq.update(answer: params[:faq][:answer], answered_by_user: current_user)
      redirect_to faqs_path, notice: 'Réponse ajoutée avec succès.' # Redirection avec un message de succès
    else
      redirect_to faqs_path, alert: 'Vous n\'êtes pas autorisé à répondre à cette question.' # Redirection avec un message d'alerte si non autorisé
    end
  end

  private

  def faq_params
    params.require(:faq).permit(:question, :answer, :role) # Définit les paramètres autorisés pour une FAQ
  end

  def authorize_role(expected_role)
    if current_user.role == expected_role || (expected_role == 'both' && current_user.role == 'both')
      yield # Exécute le bloc si l'utilisateur a le rôle attendu
    else
      redirect_to root_path, alert: 'Accès refusé' # Redirection avec un message d'alerte si accès refusé
    end
  end
end
