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

  end

  def edit

  end

  def update

  end

  def destory

  end

  private


end
