class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  validates_presence_of :description
end
