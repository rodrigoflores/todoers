require File.dirname(__FILE__) + '/acceptance_helper'

feature "Outside todo-lists", %q{
  In order to create a list
  As a non registeed
  I want to view lists
} do

  background do
    @user = Factory(:user, :password => 'mypassword', :password_confirmation => 'mypassword')
    @public_list = Factory(:todo_list, :name => 'public list', :public => true)
    @private_list = Factory(:todo_list, :name => 'private list')
  end
  
  scenario "List index" do
    visit homepage
    click_link("To-do-lists")
    page.should have_content('public list')
  end
  
  scenario "List show with public list" do
    visit homepage
    click_link("To-do-lists")
    click_link("public list")
    pending
  end
  
  scenario "List show with private list" do
    visit "/todo_lists/#{@private_list.id}"
    page.should have_content("Your access to this list is forbidden")
    
  end
end
