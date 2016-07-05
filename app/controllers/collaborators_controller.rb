class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:id])
    @collaborators = Collaborators.new
  end

  def create
  ##does user exist user.where(email: )
  ##email doesnt exist with current_user
  ##user already assigned?
  ##overall error message

  ##
  end