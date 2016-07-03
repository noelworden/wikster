class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:id])
    @collaborators = Collaborators.new
  end

  