Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'batch', to: 'batch#index', as: 'batches'
  get 'batch/:id', to: 'batch#show', as: 'batch'
  get 'shoppinglist', to: 'shoppinglist#index', as: 'shoppinglist_history'
  get 'shoppinglist/new', to: 'shoppinglist#new', as: 'new_shoppinglist'
  get 'shoppinglist/:id', to: 'shoppinglist#show', as: 'shoppinglist'
  post 'shoppinglist', to: 'shoppinglist#create'
  get 'shoppinglist/:id/edit', to: 'shoppinglist#edit', as: 'edit_shoppinglist'
  patch 'shoppinglist/:id', to: 'shoppinglist#update', as: 'update_shoppinglist'
  delete 'shoppinglist/:id', to: 'shoppinglist#destroy', as: 'delete_shoppinglist'
end
