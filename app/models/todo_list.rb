class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todo_items
  validates_presence_of :name
  has_and_belongs_to_many :users_watching, :join_table => "users_watched_lists", :foreign_key => "list_id", :class_name => "Users", :uniq => true
  
  
  accepts_nested_attributes_for :todo_items, :allow_destroy => true, :reject_if =>  proc { |attributes| attributes[:description].blank? } 
  
  def reachable?(user)
    user == self.user || self.public?
  end
  
  scope :public,  where( :public => true)
end
