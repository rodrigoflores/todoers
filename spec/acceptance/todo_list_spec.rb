require File.dirname(__FILE__) + '/acceptance_helper'


feature "logged in todo-lists!", %q{
  In order to self-organize
  As a user
  I want to see a list as the owner
} do
  
  background do
    @user = Factory(:user, :name => 'Zé', :password => 'pppppp', :password_confirmation => 'pppppp')
    @list = Factory(:todo_list, :name => 'grocery itens', :public => true, :user => @user)
    visit homepage
    log_in(@user,'pppppp')
  end

  scenario 'view a list of todo-lists' do
    click_link("My page")
    page.should have_content(@list.name)
    log_out
  end
  
  scenario "view a todo-list as the owner" do
    visit "users/#{@user.id}/todo_lists/#{@list.id}"
    page.should have_content(@list.name)
    log_out
  end
  

end
