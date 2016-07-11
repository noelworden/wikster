class WikisController < ApplicationController
# skip_before_action :authenticate_user!
  # def index
  #   @wikis = Wiki.visible_to(current_user)
  #   authorize @wikis
  # end

  before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  
  def index
    @wikis = Wiki.user_viewable(current_user)
    # @wikis = Wiki.all
    # authorize @wikis
  end

  def show
    
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
    authorize @wiki
  end

  def update
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

  def set_wiki
    @wiki = Wiki.find(params[:id])
  end
end