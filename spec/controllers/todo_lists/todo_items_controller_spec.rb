require 'spec_helper'

describe TodoLists::TodoItemsController do
  before do
    @user = Factory(:user)
    @todo_list = Factory(:todo_list, :user => @user)
    @todo_item = Factory(:todo_item, :todo_list => @todo_list)
  end
  
  
  describe "authenticated" do
    describe "delete destroy" do
      def delete_it
        delete :destroy, :todo_list_id => @todo_list.id, :id => @todo_item.id, :format => 'js'
      end
      
      it 'should decrease one' do
        lambda { 
          delete_it
        }.should change(@todo_list.todo_items,:count).by(-1) 
      end
      
      it 'should render nothing' do
        delete_it
        response.body.should be_blank
      end
    end
    
    describe 'put complete' do
      def put_it 
        put :complete, :todo_list_id => @todo_list.id, :id => @todo_item.id, :format => 'js'
      end
      
      it 'should complete the item' do
        lambda {
          put_it
          @todo_item.reload
        }.should change(@todo_item, :done)
      end
      
      it 'should render nothing' do
        put_it
        response.body.should be_blank
      end
    end
    
    describe 'post create' do
      describe 'successful' do
        it 'should create a new todo_item'
        
        it 'should return a json with the data'
      end
      
      describe 'failure' do
        it 'should not create a new todo_item'
      
        it 'should return a json with the errors'
      end
      

    end
    
  end
end
