class ShoppinglistController < ApplicationController
  def index
    @shoppinglists = ShoppingList.all
  end
  def show
    @shoppinglist = ShoppingList.find(params[:id])
  end
end
