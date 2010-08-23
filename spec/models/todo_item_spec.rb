require 'spec_helper'

describe TodoItem do
  describe 'associations' do
    it { should belong_to :todo_list } 
  end
  
  describe 'validations' do
    it { should validate_presence_of :description}
  end
  
  describe 'error_hash' do
    it 'should return a hash with the errors and its fields'
  end
  
end
