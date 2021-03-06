require File.dirname(__FILE__) + '/acceptance_helper'


feature "Non photo upload", %q{
  In order to create an account
  As a dumb
  I want to add a file that is not a photo
} do
  scenario "non-photo upload" do
    visit homepage
    click_link "Sign up"
    fill_in "user_email", :with => "john@doe.com"
    fill_in "user_password", :with => "mypassword"
    fill_in "user_password_confirmation", :with => "mypassword"
    attach_file('user_photo', 'config.ru')
    click_button 'user_submit'
    page.should have_content("Photo is not an allowed type of file.")
  end
end

feature "Create a user", %q{
  In order to use the app
  As a non registered user
  I want to create my user
} do

  scenario "User creation" do
    visit homepage
    page.should have_content("Sign up")
    click_link "Sign up"
    fill_in "user_name", :with => "John Doe"
    fill_in "user_email", :with => "john@doe.com"
    fill_in "user_password", :with => "mypassword"
    fill_in "user_password_confirmation", :with => "mypassword"
    attach_file('user_photo', 'public/images/rails.png')
    click_button("Sign up")
    page.should have_content("You have signed up successfully")
    log_out
  end
end

feature "Do not create a user with a wrong confirmation", %q{
  In order to use the app
  As a non registered user
  I want to create my user but I have a typo on my confirmation
} do

  scenario "Scenario name" do
    visit homepage
    page.should have_content("Sign up")
    click_link "Sign up"
    fill_in "user_email", :with => "john@doe.com"
    fill_in "user_password", :with => "mypassword"
    fill_in "user_password_confirmation", :with => "mypassword2"
    click_button("Sign up")
    page.should_not have_content("You have signed up successfully")
    page.should have_content("Password doesn't match confirmation")
  end
end

feature "Log in", %q{
  In order to access my stuff
  As a registered user
  I want to log in
} do
  
  background do
    @user = Factory(:user, :password => 'mypassword', :password_confirmation => 'mypassword')
  end

  scenario "Scenario name" do
    log_in(@user, "mypassword")
    page.should have_content(@user.email)
    log_out
  end
end

feature "Wrong password", %q{
  In order to prevent access from others
  As a non registered user
  I want to prevent a login with a wrong password
} do
  
  background do
    @user = Factory(:user, :password => 'mypassword', :password_confirmation => 'mypassword')
  end

  scenario "Scenario name" do
    visit '/'
    click_link "Sign in"
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => "yourspassword"
    click_button "user_submit"
    page.should_not have_content("Signed in successfully")
    page.should have_content("Invalid email or password.")
  end
end

feature "Forgot password", %q{
  In order to recover my password
  As a registered user
  I want to recover my password
} do
  
  background do
    @user = Factory(:user, :password => 'mypassword', :password_confirmation => 'mypassword')
  end

  scenario "Scenario name" do
    visit '/'
    click_link "Sign in"
    click_link "Forgot your password?"
    fill_in "user_email", :with => @user.email
    click_button "user_submit"
    mail_body = Hpricot(Mail::TestMailer.deliveries.last.body.to_s)
    reset_url = mail_body.search('#change_password_link').first[:href]
    visit reset_url
    page.should have_content("Change your password")
    fill_in "user_password", :with => 'kalala'
    fill_in "user_password_confirmation", :with => 'kalala'
    click_button "user_submit"
    page.should have_content("Your password was changed successfully")
    log_out
    log_in(@user,'kalala')
    page.should have_content(@user.email)
    log_out
  end
end




