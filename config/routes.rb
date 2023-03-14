Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get 'product', to: 'product#index', as: 'products'
  get 'product/:id', to: 'product#show', as: 'product'
  get 'list/:id', to: 'list#show', as: 'list'

  # post 'list', to: 'list#create'
  get 'list/:id/edit', to: 'list#edit', as: 'edit_list'
  patch 'list/:id', to: 'list#update', as: 'update_list'
  delete 'list/:id', to: 'list#destroy', as: 'delete_list'
  get 'products/:id/store_products/:id', to: 'store_product#show', as: 'store_product'
  get 'products/:id/store_products/:id/price_chart', to: 'price_chart#show', as: 'price_chart'
  get 'products/:id/listitem', to: 'list_item#index', as: 'list_items'
  get 'products/:id/listitem/new', to: 'list_item#new', as: 'new_list_item'
  get 'listitem/:id', to: 'list_item#show', as: 'list_item'
  post 'products/:id/listitem', to: 'list_item#create', as: 'create_list_item'
  get 'listitem/:id/edit', to: 'list_item#edit', as: 'edit_list_item'
  patch 'listitem/:id', to: 'list_item#update', as: 'update_list_item'
  delete 'listitem/:id', to: 'list_item#destroy', as: 'delete_list_item'
  get 'store_locator', to: 'store_locator#index', as: :store_locator

  # Routes for product categories (e.g. fruits, bakery, deli, etc.)
  # These are HARDCODED
  get 'fruit', to: 'product#find_fruits'
  get 'bakery', to: 'product#find_bakery'
  get 'deli', to: 'product#find_deli'
  get 'pantry', to: 'product#find_pantry'
  get 'frozen', to: 'product#find_frozen'
  get 'health', to: 'product#find_health'
  get 'drinks', to: 'product#find_drinks'
  get 'meat', to: 'product#find_meats'
end
