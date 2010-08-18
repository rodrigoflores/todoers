class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :photo, PhotoUploader
         
  attr_accessible :email, :password, :password_confirmation, :remember_me, :photo, :remote_photo_url, :photo_cache, :remove_photo
  validates_presence_of :name

end
