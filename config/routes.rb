Rails.application.routes.draw do
  namespace :admin do
      resources :bids
      resources :categories
      resources :faqs
      resources :histories
      resources :notifications
      resources :payments
      resources :products
      resources :reviews
      resources :users

      root to: "bids#index"
    end
  # Pages statiques
  get 'pages/contact'
  get 'home/index'
  get 'contact_us', to: 'pages#contact', as: 'contact_us'

  # Devise pour l'authentification des utilisateurs
  devise_for :users

  # Routes spécifiques pour les FAQ selon le rôle
  get 'faqs/seller', to: 'faqs#seller', as: 'seller_faq'
  get 'faqs/buyer', to: 'faqs#buyer', as: 'buyer_faq'
  get 'faqs/both', to: 'faqs#both', as: 'both_faq'

  # Définir la route pour les catégories
  get 'products/category/:name', to: 'products#category', as: 'category_products'

  # Gestion des produits avec une action de recherche
  resources :products do
    collection do
      get 'search'
      get 'historique'
    end
    
    resources :bids, only: [:new, :create, :index]
  end

  # Route pour l'historique des enchères de l'utilisateur
  get 'user/bids_history', to: 'histories#user_history', as: 'user_bids_history'
  get 'historique', to: 'products#historique'
  # Routes pour les utilisateurs
  get 'users/:id/profile', to: 'users#profile', as: 'user_profile'
  get 'users/:id/products', to: 'products#user_products', as: 'user_products'

  # Routes pour d'autres ressources
  resources :bids, only: [:index]
  resources :histories
  resources :payments
  resources :reviews
  resources :notifications
  resources :categories

  # Routes pour les FAQ
  resources :faqs do
    member do
      post 'create_response'  # Pour ajouter des réponses à une FAQ existante
    end
  end

  # Définir la route racine
  root 'home#index'
end
