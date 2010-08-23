require 'spec_helper'

describe TodoList do
  should_accept_nested_attributes_for :todo_items
  
  describe 'validations' do
    should_validate_presence_of :name
  end
  
  describe 'scopes' do
    it { should have_scope(:public, :where => {:public => true})}
  end
  
  describe 'associations' do
    should_belong_to :user
    should_have_many :todo_items
    it { should have_and_belong_to_many :users_watching, :join_table => "users_watched_lists", :foreign_key => "list_id", :class_name => "Users", :uniq => true}
  end
  
  describe 'reachable?' do
    before do
      @alice = Factory(:user)
      @bob = Factory(:user, :email => 'bob@bob.com')
      @public_list = Factory(:todo_list, :public => true, :user => @alice)  
      @private_list = Factory(:todo_list, :public => false, :user => @alice)  
      
    end
    
    describe 'public list' do

      
      it 'should be reachable, if the owner is the user' do
        @public_list.should be_reachable(@alice)
      end
      
      it 'should be reachable, if the owner is not the user' do
        @public_list.should be_reachable(@bob)
      end
      
    end
    
    describe 'private list' do

      
      it 'should be reachable, if the owner is the user' do
        @private_list.should be_reachable(@alice)
      end
      
      it 'should not be reachable, if the owner is not the user' do
        @private_list.should_not be_reachable(@bob)
      end
      
    end
  end
  
  
end
