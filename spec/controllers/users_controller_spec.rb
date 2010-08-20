require 'spec_helper'

describe UsersController do
  before do
    @user = Factory(:user)
  end
    
  describe 'get show' do
    before :each do
      get :show, :id => @user.id
    end
    
    it 'should assign user' do  
      assigns[:user].should == @user
    end
    
    it 'should render template' do
      should render_template 'show'
    end

  end

end
