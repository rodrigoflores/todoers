require 'spec_helper'

describe TodoListsController do
  before do
    @user = Factory(:user)
    @todo_list = Factory(:todo_list, :user => @user)
    @another_user = Factory(:user, :email => 'a@bbb.com')
    @another_todo_list = Factory(:todo_list, :user => @another_user)
  end
  
  describe "not authenticated" do
    describe 'get index' do
      
      before(:each) do
        get :index
      end
      
      it 'should render index' do
        should redirect_to new_user_session_path
      end
    end
  end
  
  describe "authenticated as not the owner" do
    before do
      
      sign_in @user
    end
    
    describe 'get show' do      
      before(:each) do
        get :show, :id => @another_todo_list.id
      end
      
      xit 'should render index' do
        should redirect_to root_path
      end
    end
  end
  
  describe 'authenticated as owner' do
    before do
      sign_in @user
    end

    describe 'get index' do
      
      before(:each) do
        get :index
      end
      
      it 'should render index' do
        should render_template 'index'
      end
      
      it 'should assign todo_lists' do
        assigns[:todo_lists].should == [@todo_list]
      end
    end
    
    describe 'get new' do
      it 'should render new' do
        get :new
        should render_template 'new'
      end
      
      it 'should assign a todo_list that belongs to current user' do
        get :new
        assigns[:todo_list].should be_kind_of(TodoList)
        assigns[:todo_list].user.should == @user
      end
    end
    
    describe 'post create' do
      describe 'successful' do
        def post_it
          post :create, :todo_list => Factory.attributes_for(:todo_list)
        end

        it 'should increase the to_do_list counter' do
          lambda {
            post_it
          }.should change(@user.todo_lists,:count).by(1)
        end
        
        it 'should redirect to the page' do
          post_it
          @todo_list = @user.todo_lists.last
          should redirect_to todo_list_path(@todo_list)
        end
        
      end
      
      describe 'failure' do
        def post_it
          post :create, :todo_list => Factory.attributes_for(:todo_list, :name => "")
        end
        it 'should not increase the to_do_list counter' do
          lambda {
            post_it
          }.should_not change(@user.todo_lists, :count)
        end
        
        it 'should render new' do
          post_it
          should render_template 'new'
        end
      end
    end
    
    describe "put update" do
      describe 'successful' do
        def put_it
          put :update, :todo_list => Factory.attributes_for(:todo_list, :name => 'jingle bell'), :id => @todo_list.id
        end

        it 'should increase the to_do_list counter' do
          lambda {
            put_it
            @todo_list.reload
          }.should change(@todo_list,:name)
        end
        
        it 'should redirect to the page' do
          put_it
          should redirect_to todo_list_path(@todo_list)
        end 
      end
      
      describe "failure" do
        def put_it
          put :update, :todo_list => Factory.attributes_for(:todo_list, :name => ''), :id => @todo_list.id
        end

        it 'should increase the to_do_list counter' do
          lambda {
            put_it
            @todo_list.reload
          }.should_not change(@todo_list,:name)
        end
        
        it 'should redirect to the page' do
          put_it
          should render_template 'edit'
        end 
        
      end
    end
    
    [:show, :edit].each do |action|
      describe "get #{action}" do
        before(:each) do
          get action, :id => @todo_list.id
        end
      
        it "should render #{action}" do
          should render_template action.to_s
        end
      
        it 'should assign @todo_list' do
          assigns[:todo_list].should == @todo_list
        end
      end
    end
    
    describe "delete destroy" do 
      def delete_it
        delete :destroy, :id => @todo_list.id
      end
          
      it "should redirect to index" do
        delete_it
        should redirect_to todo_lists_path
      end
    
      it 'should assign @todo_list' do
        lambda { 
          delete_it          
        }.should change(@user.todo_lists,:count).by(-1)
      end
    end
  end
end
