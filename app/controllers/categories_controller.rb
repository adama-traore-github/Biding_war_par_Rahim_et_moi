class CategoriesController < ApplicationController
  before_action :authenticate_user! # Assure que l'utilisateur est authentifié avant d'accéder aux actions

  def index
    @categories = Category.all # Récupère toutes les catégories
    render json: @categories # Rendu des catégories en format JSON
  end

  def show
    @category = Category.find(params[:id]) # Trouve la catégorie par son ID
    render json: @category # Rendu de la catégorie en format JSON
  end

  def new
    @category = Category.new # Crée une nouvelle instance de catégorie
  end

  def create
    @category = Category.new(category_params) # Crée une nouvelle catégorie avec les paramètres fournis
    if @category.save # Tente de sauvegarder la catégorie
      render json: @category, status: :created # Rendu de la catégorie en format JSON avec statut créé
    else
      render json: @category.errors, status: :unprocessable_entity # Rendu des erreurs de la catégorie en format JSON avec statut non traitable
    end
  end

  def edit
    @category = Category.find(params[:id]) # Trouve la catégorie par son ID pour l'édition
  end

  def update
    @category = Category.find(params[:id]) # Trouve la catégorie par son ID pour la mise à jour
    if @category.update(category_params) # Tente de mettre à jour la catégorie avec les paramètres fournis
      render json: @category # Rendu de la catégorie mise à jour en format JSON
    else
      render json: @category.errors, status: :unprocessable_entity # Rendu des erreurs de la mise à jour en format JSON avec statut non traitable
    end
  end

  def destroy
    @category = Category.find(params[:id]) # Trouve la catégorie par son ID pour la suppression
    @category.destroy # Supprime la catégorie
    head :no_content # Réponse sans contenu pour indiquer que la suppression a réussi
  end

  private

  def category_params
    params.require(:category).permit(:name, :description) # Définit les paramètres autorisés pour une catégorie
  end
end
