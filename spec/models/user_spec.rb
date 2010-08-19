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

require 'spec_helper'

describe User do
  it 'should have a PhotoUploader calld photo' do
    should have_column(:photo)
    @user = Factory(:user)
    @user.photo.should be_kind_of(PhotoUploader)
  end
  describe 'validations' do 
    should_validate_presence_of(:name)
  end
  
  describe 'associations' do
    should_have_many :todo_lists
  end
  
end
