class WikisController < ApplicationController

  # def index
  #   @wikis = Wiki.visible_to(current_user)
  #   authorize @wikis
  # end
  
  def index
    if user_signed_in?
      @wikis = Wiki.private_viewing
    else
      @wikis = Wiki.public_viewing
    end
    #@wikis = Wiki.visible_to(current_user)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
     authorize @wiki
  end

  def create
     @wiki = current_user.wikis.create(wiki_params)
     authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved!"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an issue saving that wiki"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated!"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an issue updating that wiki"
      render :edit
    end
  end
  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully"
      redirect_to action: :index

    else
      flash.now[:alert] = "error, error, error"
      redirect_to @wiki
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end