# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime 
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  photo                :string(255)
#  name                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_and_belongs_to_many :watched_list, :join_table => "users_watched_lists", :foreign_key => "user_id", :class_name => "TodoList", :uniq => true
  
  mount_uploader :photo, PhotoUploader
         
  attr_accessible :email, :password, :password_confirmation, :remember_me, :photo, :remote_photo_url, :photo_cache, :remove_photo, :name
  validates_presence_of :name
  
  has_many :todo_lists

end
