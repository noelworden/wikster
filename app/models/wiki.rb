class Wiki < ActiveRecord::Base
  belongs_to :user
  
  has_many :collaborators
  has_many :users, through: :collaborators

  # scope :visible_to, -> (user) { user.role == 'admin' || user.role == 'premium' ? all : where(private: false) }
  scope :private_viewing, -> {Wiki.where(private: true)}
  scope :public_viewing, -> {Wiki.where(private: false)}
  # scope :private_viewing, -> {Wiki.where(user_id: user.id)}
  # scope :visible_to, -> (user) { user ? (where(private: false).where(user_id: user)) : where(private: false)} ## works if the || and following element is removed##
  # scope :visible_to, -> (user) { user ? all : where(private: false)}

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
