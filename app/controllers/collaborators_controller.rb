class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])

    user = User.where(email: params[:email]).first

    if user.nil?
      flash[:error] = "There is no user with the email #{params[:email]}"
    elsif @wiki.users.include?(user)
      flash[:error] = "#{params[:email]} is already a collaborator"
    elsif user == current_user
      flash[:error] = "Can't add self as collaborator"
    else
      if Collaborator.create(wiki: @wiki, user: user)
        flash[:notice] = "Collaborator added"
      else
        flash[:error] = "Something went wrong"
      end
    end

    redirect_to edit_wiki_path(@wiki)
  end
end


### colab.user with link_to to the side on the view set method: :delete
### setup destroy method
