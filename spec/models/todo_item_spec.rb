require 'spec_helper'

describe TodoItem do
  describe 'associations' do
    it { should belong_to :todo_list } 
  end
  
  describe 'validations' do
    it { should validate_presence_of :description}
  end
  
  describe 'error_hash' do
    it 'should return a hash with the errors and its fields' do
      @list = Factory(:todo_list)
      @todo_item = Factory.build(:todo_item, :description => '',:todo_list => @list)
      @todo_item.save
      @todo_item.error_hash.should == [{:field => :description, :description => "can't be blank"}]
      
    end
  end
  
end
