class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    
  ##does user exist user.where(email: )
  ##email doesnt exist with current_user
  ##user already assigned?
  ##overall error message

  ##
  end