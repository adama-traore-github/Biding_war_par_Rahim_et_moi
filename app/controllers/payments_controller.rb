class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product_id = params[:product_id]
    @product = Product.find_by(id: @product_id)

    if @product.nil?
      redirect_to root_path, alert: 'Produit non trouvé.'
    else
      @amount = @product.current_price # Le prix actuel du produit en euros
    end
  end

  def create
    amount = params[:amount].to_f

    stripe_token = params[:stripeToken]

    if amount <= 0
      flash[:notice] = "Le montant à payer doit être positif."
      redirect_to new_payment_path(product_id: params[:product_id])
      return
    end

    if stripe_token.blank?
      flash[:alert] = "Détails de paiement invalides"
      redirect_to new_payment_path(product_id: params[:product_id])
      return
    end

    begin
      Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

      charge = Stripe::Charge.create(
        amount: (amount * 100).to_i,
        currency: 'eur',
        source: stripe_token,
        description: 'Paiement pour produit'
      )
      flash[:notice] = "Paiement réussi"
    rescue Stripe::CardError => e
      flash[:alert] = e.message
    end

    redirect_to product_path(params[:product_id])
  end
end
