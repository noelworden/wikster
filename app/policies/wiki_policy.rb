class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def update?
    user.present? && (record.user == user || user.admin? || record.users.include?(user)) # get collaborators
  end

  def edit?
    update?
  end

  def can_edit_collaborators?
     user.present? && (record.user == user || user.admin?)
  end
end