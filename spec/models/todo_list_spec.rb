require 'spec_helper'

describe TodoList do
  describe 'validations' do
    should_validate_presence_of :name
  end
  
  describe 'associations' do
    should_belong_to :user
  end
  
  
end
