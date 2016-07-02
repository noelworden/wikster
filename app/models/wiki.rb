class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :visible_to, -> (user) { user ? all : where(private: false)}
  # scope :visible_to, -> (admin) { admin ? all : where(private: false || true)}
end
