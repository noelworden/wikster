class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
     @wiki = current_user.wikis.create(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was saved!"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an issue saving that wiki"
      render :new
    end
  end

  def edit
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end