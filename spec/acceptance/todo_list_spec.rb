require File.dirname(__FILE__) + '/acceptance_helper'


feature "viewing my todo-lists", %q{
  In order to self-organize
  As a user
  I want to see my list as the owner
} do
  
  background do
    @user = Factory(:user, :name => 'Zé', :password => 'pppppp', :password_confirmation => 'pppppp')
    @list = Factory(:todo_list, :name => 'grocery itens', :public => true, :user => @user)
    log_in(@user,'pppppp')
    visit homepage
  end
  
  scenario 'view a list of todo-lists on an index page' do
    click_link("My page")
    click_link("My to-do lists")
    page.should have_content(@list.name)
    log_out
  end

  scenario 'view a list of todo-lists on my page' do
    click_link("My page")
    page.should have_content(@list.name)
    log_out
  end
  
  scenario "view a todo-list as the owner" do
    click_link("My page")
    click_link(@list.name)
    page.should have_content(@list.name)
    log_out
  end
  
  scenario "create a new to-do list" do
    click_link("My page")
    click_link("My to-do lists")
    click_link("New to-do list")
  end
  

end
