class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  validates_presence_of :description
  
  def error_hash
    self.errors.map { |error| { :field => error.first, :description => error.last }}
  end
end
