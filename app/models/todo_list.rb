class TodoList < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name
  
  def reachable?(user)
    user == self.user || self.public?
  end
end
