require 'spec_helper'

shared_examples_for "showing a list with an access granted" do
  before :each do 
    get :show, :user_id => user.id, :id => list.id
  end

  it 'should assign @todo_list' do
    assigns[:todo_list].should == list
  end

  it 'should render template show' do
    should render_template 'show'
  end
end

describe Users::TodoListsController do
  before do
    @user = Factory(:user)
    @another_user = Factory(:user, :email => 'rick@astley.com')
    @public_list = Factory(:todo_list, :public => true, :user => @user)
    @private_list = Factory(:todo_list, :public => false, :user => @user)
  end
  
  describe 'authenticated' do

    
    describe 'owner' do
      before do
        sign_in @user
      end
      
      after do
        sign_out @user
      end

      describe 'get show' do
        describe 'public list' do
          let(:list) { @public_list }
          let(:user) { @user }
          it_should_behave_like 'showing a list with an access granted'
        end
        
        describe 'private list' do        
          let(:list) { @private_list }
          let(:user) { @user }
          it_should_behave_like 'showing a list with an access granted'
        end
        
      end
    end
    
    describe 'not owner' do
      before do
        sign_in @another_user
      end
      
      describe 'public list' do
        let(:list) { @public_list }        
        let(:user) { @user }
        it_should_behave_like 'showing a list with an access granted'
        
        describe 'watch_todo_list' do
          it 'should add the list to the watch list' do
            lambda { 
              put :watch_todo_list, :user_id => @user.id, :id => @public_list.id
            }.should change(@another_user.watched_lists, :count).by(1)
          end
          
          it 'should render nothing' do
            put :watch_todo_list, :user_id => @user.id, :id => @public_list.id
            response.body.should == " "
          end
        end
      end
      
      describe 'private list' do
        before(:each) do
          get :show, :user_id => @user.id, :id => @private_list.id          
        end
        
        it 'should redirect the user' do
          should redirect_to root_path
        end
        
        it 'should flash something' do
          flash[:alert].should_not be_blank
        end

      end
      
      after do
        sign_out @another_user
      end
    end      
  end
  
  
  describe 'not authenticated' do
    
    describe 'get index' do
      before :each do
        get :index, :user_id => @user.id
      end
  
      it 'should assign @todo_list' do
        assigns[:todo_lists].should == [@public_list]
      end
      
      it "should render template 'index'" do
        should render_template 'index'
      end  
    end

    describe 'private list' do
      describe 'get show' do
        before :each do 
          get :show, :user_id => @user.id, :id => @private_list.id
        end
        
        it 'should redirect to root' do
          should redirect_to root_path
        end
        
        it 'should flash something' do
          flash[:alert].should_not be_nil
        end
        
      end
      
    end
    
    describe 'public list' do
      
      describe 'get show' do
        let(:list) { @public_list }
        let(:user) { @user }
        it_should_behave_like 'showing a list with an access granted'
      end
    end
  end
end