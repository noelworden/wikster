class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  # def update?
  #   user.admin?
  # end

  # def edit?
  #   update?
  # end
  
end