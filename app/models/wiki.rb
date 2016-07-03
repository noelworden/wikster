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
end
