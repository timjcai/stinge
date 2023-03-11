class ListItemController < ApplicationController
  def index
    @listitems = ListItem.all
  end

  def show
    @listitem = ListItem.find(params[:id])
  end

  def new
    @listitem = ListItem.new
  end

  def create
    @listitem = ListItem.new(product_id: params[:id], list: current_user.default_list, quantity: params[:quantity])
    @listitem.save
    redirect_to products_path
  end

  def edit

  end

  def update

  end

  def destroy
    @listitem = ListItem.find(params[:id])
    list_id = @listitem.list_id
    @listitem.destroy
    redirect_to list_path(list_id), status: :see_other
  end

  private

  def listitem_params
    params.require(:listitem).permit(:id, :list_id, :quantity)
  end
end
