module HelperMethods
  def log_out
    visit homepage
    click_link "Log out"
  end

  def log_in(user,password)
    visit homepage
    click_link "Sign in"
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => password
    click_button "user_submit"
  end
  
end

RSpec.configuration.include HelperMethods, :type => :acceptance
