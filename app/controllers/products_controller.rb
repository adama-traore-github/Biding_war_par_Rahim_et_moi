class ProductsController < ApplicationController
  # Authentification obligatoire pour certaines actions
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :historique]
  
  # Définit le produit en fonction de l'ID avant certaines actions
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # Affiche tous les produits ou ceux d'une catégorie spécifique
  def index
    @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @category.products # Produits filtrés par catégorie
    else
      @products = Product.all # Tous les produits
    end
  end

  # Affiche les produits de l'utilisateur connecté
  def user_products
    @products = current_user.products
    render :index # Affiche la vue index avec les produits de l'utilisateur
  end
  
  # Affiche un produit spécifique
  def show
  end

  # Affiche l'historique des enchères terminées
  def historique
    @products = Product.where('auction_end_date < ?', Time.current) # Produits dont l'enchère est terminée
  end

  # Formulaire pour créer un nouveau produit
  def new
    @product = Product.new
  end

  # Crée un nouveau produit et l'associe à l'utilisateur actuel
  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to root_path, notice: 'Produit créé avec succès.' # Redirection après création réussie
    else
      puts @product.errors.full_messages # Affiche les erreurs dans la console
      flash.now[:alert] = @product.errors.full_messages.to_sentence # Affiche les erreurs à l'utilisateur
      render :new # Réaffiche le formulaire en cas d'échec
    end
  end

  # Formulaire d'édition d'un produit
  def edit
  end

  # Met à jour un produit existant
  def update
    if @product.update(product_params)
      render json: @product # Retourne le produit mis à jour en JSON
    else
      render json: @product.errors, status: :unprocessable_entity # Retourne les erreurs en JSON
    end
  end

  def search
    @query = params[:query]
    @products = Product.where('name LIKE ?', "%#{@query}%")
  end

  # Supprime un produit
  def destroy
    @product.destroy
    head :no_content # Réponse sans contenu après suppression
  end

  # Filtre les produits par catégorie
  def category
    @category = Category.find_by(name: params[:name])
    if @category
      @products = @category.products # Filtre par catégorie
    else
      @products = Product.all # Retourne tous les produits si aucune catégorie n'est trouvée
    end
    render :index
  end

  private

  # Recherche un produit par ID
  def set_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      render json: { error: 'Product not found' }, status: :not_found # Retourne une erreur si le produit n'est pas trouvé
    end
  end

  # Permet de filtrer les paramètres autorisés pour un produit
  def product_params
    params.require(:product).permit(:name, :description, :category_id, :initial_price, :auction_start_date, :auction_end_date, :image)  
  end
end
