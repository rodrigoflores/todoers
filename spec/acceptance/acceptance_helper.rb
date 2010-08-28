require File.dirname(__FILE__) + "/../spec_helper"
require "steak"
require 'capybara/rails'

RSpec.configuration.include Capybara, :type => :acceptance

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.before(:each, :type => :acceptance) do
    Capybara.reset_sessions!
    DatabaseCleaner.clean  
  end
  
  config.after(:all, :type => :acceptance) do
    DatabaseCleaner.clean  
  end
end

