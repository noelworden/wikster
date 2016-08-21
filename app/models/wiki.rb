class Wiki < ActiveRecord::Base
  belongs_to :user

  has_many :collaborators
  has_many :users, through: :collaborators

  scope :private_viewing, -> {Wiki.where(private: true)}
  scope :public_viewing, -> {Wiki.where(private: false)}

  default_scope {order('updated_at DESC')}

  def self.user_viewable(user)
    return Wiki.public_viewing if user.nil?
    wikis = []

    Wiki.all.each do | wiki|
      if wiki.private && (wiki.user == user || wiki.users.include?(user)) || !wiki.private
        wikis << wiki
      end
    end
    wikis
  end
end
