class TodoListsController < InheritedResources::Base
  before_filter :public_access_to_list?, :only => :show
    
  protected
    def collection
      @todo_lists = TodoList.find_all_by_public(true)
    end
    
    def resource
      @todo_list = TodoList.find(params[:id])
    end
end
