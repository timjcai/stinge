Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'batch', to: 'batch#index', as: 'batches'
  get 'batch/:id', to: 'batch#show', as: 'batch'
  get 'shoppinglist', to: 'shoppinglist#index', as: 'shoppinglist_history'
  get 'shoppinglist/:id', to: 'shoppinglist#show', as: 'shoppinglists'
end
