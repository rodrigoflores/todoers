class TodoListsController < InheritedResources::Base
  before_filter :authenticate_user!
  def new
    # @todo_list = current_user.todo_lists.new
    super do 
      40.times do 
        resource.todo_items.build
      end
    end
  end
  
  protected
    def begin_of_association_chain
      current_user
    end
end
