class ShoppinglistController < ApplicationController
  before_action :set_shoppinglist, only: [:show, :edit, :update, :destroy]
  def index
    @shoppinglists = ShoppingList.all
  end

  def show
  end

  def new
    @shoppinglist = ShoppingList.new
  end

  def create
    @shoppinglist = ShoppingList.new(shoppinglist_params)
  end

  def edit
  end

  def update
    @shoppinglist.update(params[:shoppinglist])
    redirect_to shoppinglist_path(@shoppinglist)
  end

  def destroy
    @shoppinglist.destroy
    redirect_to shoppinglist_path, status: :see_other
  end

  private

  def set_shoppinglist
    @shoppinglist = ShoppingList.find(params[:id])
  end


  def shoppinglist_params
    params.require(:shoppinglist).permit(:name, :user_id)
  end
end
