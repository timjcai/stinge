Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'product', to: 'product#index', as: 'products'
  get 'product/:id', to: 'product#show', as: 'product'
  get 'list', to: 'list#index', as: 'lists'
  get 'list/new', to: 'list#new', as: 'new_list'
  get 'list/:id', to: 'list#show', as: 'list'
  post 'list', to: 'list#create'
  get 'list/:id/edit', to: 'list#edit', as: 'edit_list'
  patch 'list/:id', to: 'list#update', as: 'update_list'
  delete 'list/:id', to: 'list#destroy', as: 'delete_list'
  get 'product/:id/store_product/:id', to: 'store_product#show', as: 'store_product'
  get 'product/:id/store_product/:id/price_chart', to: 'price_chart#show', as: 'price_chart'

  get 'listitem', to: 'list_item#index', as: 'list_items'
  get 'listitem/new', to: 'list_item#new', as: 'new_list_item'
  get 'listitem/:id', to: 'list_item#show', as: 'list_item'
  post 'listitem', to: 'list_item#create'
  get 'listitem/:id/edit', to: 'list_item#edit', as: 'edit_list_item'
  patch 'listitem/:id', to: 'list_item#update', as: 'update_list_item'
  delete 'listitem/:id', to: 'list_item#destroy', as: 'delete_list_item'
end
