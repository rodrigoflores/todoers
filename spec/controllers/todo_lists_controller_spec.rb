require 'spec_helper'

describe TodoListsController do
  
  before do
    @public_list = Factory(:todo_list, :public => true)
    @private_list = Factory(:todo_list, :public => false)
  end
  
  describe 'with anyone' do
    describe 'get index' do
      it 'should assigns only public to-do-lists' do
        get :index
        assigns[:todo_lists].should == [@public_list]
      end
      
      it 'should render index' do
        get :index
        should render_template 'index'
      end
    end
    
    describe 'public lists' do
      describe 'get show' do
        it 'should assign to-do-list' do
          get :show, :id => @public_list.id
          assigns[:todo_list].should == @public_list
        end
    
        it 'should render show' do
          get :show, :id => @public_list.id
          should render_template 'show'
        end
      end
    end
    
    describe 'private lists' do
      it 'should redirect to index' do
        get :show, :id => @private_list.id
        should redirect_to root_path
      end
      
      it 'should flash something' do
        get :show, :id => @private_list.id
        flash[:alert].should_not be_blank
      end
    end
  end
end
