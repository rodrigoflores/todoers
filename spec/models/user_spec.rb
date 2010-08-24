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
    it { should have_and_belong_to_many :watched_lists}
    should_have_many :todo_lists
  end
  
  describe 'watched lists' do
    before(:each) do
      @user = Factory(:user)
      @another_user = Factory(:user, :email => 'otheremail@abcd.com.br')
      @list = Factory(:todo_list, :public => true, :user => @another_user)
      @private_list = Factory(:todo_list, :public => false, :user => @another_user)
    end
    
    it 'should add a public list' do
      @user.watched_lists << @list
      @user.watched_lists.count.should == 1
    end
    
    it 'should not add the same list twice' do
      2.times do 
        @user.watched_lists << @list
      end
      @user.watched_lists.count.should == 1

    end
    
    it 'should not add a private list' do
      @user.watched_lists << @private_list
      @user.watched_lists.count.should == 0
    end
    
    describe 'delete_watched_list' do
      before(:each) do
        @user.watched_lists << @list
      end
      
      it 'should delete the list' do
        lambda {
          @user.delete_watched_list(@list.id)
        }.should change(@user.watched_lists, :count).by(-1)
        
      end

    end
  end
  
end
