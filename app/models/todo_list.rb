class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todo_items
  validates_presence_of :name

  has_and_belongs_to_many :users, :join_table => "watching_list_users"
  
  accepts_nested_attributes_for :todo_items, :allow_destroy => true, :reject_if =>  proc { |attributes| attributes[:description].blank? } 
  
  def reachable?(user)
    user == self.user || self.public?
  end
  
  scope :public,  where( :public => true)
end
