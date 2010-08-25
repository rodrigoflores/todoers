require File.dirname(__FILE__) + "/../spec_helper"
require "steak"
require 'capybara/rails'

RSpec.configuration.include Capybara, :type => :acceptance

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

  config.before(:each, :type => :acceptance) do
    # Some code to run before any acceptance spec
  end
end

