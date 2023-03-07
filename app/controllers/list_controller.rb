class ListController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  def index
    @lists = List.where(user: current_user)
  end

  def show
    @listitems = ListItem.where(list: @list)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      redirect_to list_path(@list)
    else
      redirect_to new_list_path, alert: 'error'
    end
  end

  def edit
  end

  def update
    @list.update(params[:list])
    redirect_to list_path(@list)
  end

  def destroy
    @list.destroy
    redirect_to list_path, status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
