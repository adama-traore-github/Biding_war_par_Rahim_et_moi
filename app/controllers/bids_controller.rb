class BidsController < ApplicationController
  before_action :authenticate_user! # Assure que l'utilisateur est authentifié avant d'accéder aux actions

  def new
    @product = Product.find(params[:product_id]) # Trouve le produit par son ID
    @bid = @product.bids.build # Crée une nouvelle enchère pour le produit
  end

  def index
    @bids = Bid.joins(:product).where('products.auction_end_date >= ?', Time.current) # Sélectionne les enchères dont la date de fin est dans le futur
    # Pour supprimer les enchères expirées
    Bid.joins(:product).where('products.auction_end_date < ?', Time.current).destroy_all # Supprime les enchères dont la date de fin est passée
  end

  def create
    @product = Product.find(params[:product_id]) # Trouve le produit par son ID
    @bid = @product.bids.build(bid_params) # Crée une nouvelle enchère avec les paramètres fournis
    @bid.user = current_user # Associe l'enchère à l'utilisateur actuel

    if @bid.amount > @product.current_price # Vérifie si le montant de l'enchère est supérieur au prix actuel
      if @bid.save # Tente de sauvegarder l'enchère
        flash[:notice] = 'Votre enchère a été placée avec succès.' # Affiche un message de succès
        redirect_to bids_path  # Redirection vers la liste des enchères
      else
        flash.now[:alert] = 'Enchère non valide.' # Affiche un message d'erreur si l'enchère n'est pas valide
        render :new # Rends le formulaire de nouvelle enchère
      end
    else
      flash.now[:alert] = 'Le montant de l\'enchère doit être supérieur au prix actuel.' # Affiche un message d'erreur si le montant est insuffisant
      render :new # Rends le formulaire de nouvelle enchère
    end
  end

  def place_bid
    @product = Product.find(params[:product_id]) # Trouve le produit par son ID
    @bid = @product.bids.build(bid_params) # Crée une nouvelle enchère avec les paramètres fournis
    @bid.user = current_user # Associe l'enchère à l'utilisateur actuel

    if @bid.amount > @product.current_price # Vérifie si le montant de l'enchère est supérieur au prix actuel
      if @bid.save # Tente de sauvegarder l'enchère
        @bid.update(finalized_at: 24.hours.from_now) # Définir le délai de 24 heures pour la finalisation de l'enchère
        render json: { success: true, message: 'Votre enchère a été placée avec succès.', finalized_at: @bid.finalized_at.iso8601 } # Renvoie une réponse JSON avec un message de succès
      else
        render json: { success: false, message: 'Enchère non valide.' } # Renvoie une réponse JSON avec un message d'erreur
      end
    else
      render json: { success: false, message: 'Le montant de l\'enchère doit être supérieur au prix actuel.' } # Renvoie une réponse JSON avec un message d'erreur si le montant est insuffisant
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:amount) # Définit les paramètres autorisés pour une enchère
  end
end
