class HistoriesController < ApplicationController
  before_action :authenticate_user! # Assure que l'utilisateur est authentifié avant d'accéder aux actions

  def user_history
    # Récupère l'historique des enchères pour l'utilisateur actuel, trié par date d'enchère décroissante
    @histories = History.where(user_id: current_user.id).order(bid_date: :desc)
  end

  def index
    # Récupère tous les historiques et les renvoie au format JSON
    @histories = History.all
    render json: @histories
  end

  def show
    # Trouve un historique par son ID et le renvoie au format JSON
    @history = History.find(params[:id])
    render json: @history
  end

  def new
    # Crée une nouvelle instance d'historique pour le formulaire
    @history = History.new
  end

  def create
    # Crée une nouvelle instance d'historique avec les paramètres fournis
    @history = History.new(history_params)
    if @history.save
      # Sauvegarde réussie, renvoie l'historique créé au format JSON avec le statut :created
      render json: @history, status: :created
    else
      # Échec de la sauvegarde, renvoie les erreurs au format JSON avec le statut :unprocessable_entity
      render json: @history.errors, status: :unprocessable_entity
    end
  end

  def edit
    # Trouve un historique par son ID pour l'éditer
    @history = History.find(params[:id])
  end

  def update
    # Trouve un historique par son ID et le met à jour avec les paramètres fournis
    @history = History.find(params[:id])
    if @history.update(history_params)
      # Mise à jour réussie, renvoie l'historique mis à jour au format JSON
      render json: @history
    else
      # Échec de la mise à jour, renvoie les erreurs au format JSON avec le statut :unprocessable_entity
      render json: @history.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # Trouve un historique par son ID et le supprime
    @history = History.find(params[:id])
    @history.destroy
    # Renvoie une réponse vide avec le statut :no_content
    head :no_content
  end

  private

  def history_params
    # Définit les paramètres autorisés pour un historique
    params.require(:history).permit(:user_id, :product_id, :action, :timestamp)
  end
end
