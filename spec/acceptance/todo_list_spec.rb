require File.dirname(__FILE__) + '/acceptance_helper'


feature "Create a list name", %q{
  In order to self-organize
  As a user
  I want to create a list
} do

  scenario 'view a list' do
    @user = Factory(:user, :name => 'Zé', :password => 'pppppp', :password_confirmation => 'pppppp')
    @list = Factory(:todo_list, :name => 'grocery itens', :public => true, :user => @user)
    log_in(@user, 'pppppp')
    click_link("My page")
    page.should have_content(@list.name)
  end
end
