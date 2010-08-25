require File.dirname(__FILE__) + '/acceptance_helper'

feature "Requested histories", %q{
  In order to be a plataformatec employee
  As a ruby programmer
  I want to deliver the requested features on this todo list
} do
  
  background do
    @user = Factory(:user, :password => 'abcdef', :password_confirmation => 'abcdef')
    @another_user = Factory(:user, :email => 'abcd@aca.com', :name => "John Smith Doe")
    @another_todo_list = Factory(:todo_list, :user => @another_user, :name => 'my public list', :public => true)
    @todo_item = Factory(:todo_item, :description => 'lorem', :todo_list => @another_todo_list)
    log_in(@user,'abcdef')
  end

  scenario "After the login, the user can create a list and put some elements on creation" do
    click_link("My todo-lists")
    click_link("New todo-list")
    fill_in('todo_list_name',  :with => "Things to buy")
    check('todo_list_public')
    click_link("new_to_do_link")
    fill_in('todo_list_todo_items_attributes_0_description', :with => "Computer")
    click_button("Create Todo list")
    page.should have_content("Things to buy")
    page.should have_content("Computer")
    log_out
  end

  def access_a_todo_list
    visit homepage
    click_link("John Smith Doe")
    click_link("my public list")
  end
  
  scenario "seeing other user lists and items" do
    access_a_todo_list
    page.should have_content('lorem')
    log_out
  end
  
  @javascript
  scenario 'watch other users lists and see it on my profile page' do
    pending
    access_a_todo_list
    page.should have_content("Watch this list")  
    click_link("Watch this list")
    page.should_not have_content("Watch this list") 
    page.should have_content("watching")  
    visit '/todo_lists'
    page.should have_content('my public list')
    log_out
  end
end
