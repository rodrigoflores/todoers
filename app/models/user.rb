class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :photo, PhotoUploader
         
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
