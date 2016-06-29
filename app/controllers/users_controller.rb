class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def downgrade
    current_user.update_attribute(:role, 0)

    if current_user.save
      flash[:notice] = "Thats a bummer you downgraded"
      redirect_to root_url
    else
      flash.now[:alert] = "There was an issue dowgrading"
      render :edit
    end
  end
end
