class TodoListsController < InheritedResources::Base
  before_filter :authenticate_user!
  respond_to :js, :only => :unwatch_todo_list
  def new
    super do 
      40.times do 
        resource.todo_items.build
      end
    end
  end
  
  def show
    begin
      show!
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
  end
  
  def unwatch_todo_list
    current_user.delete_watched_list(params[:id])
    render :nothing => true 
  end
  
  protected
    def begin_of_association_chain
      current_user
    end
    
    def collection
      @watched_lists = current_user.watched_lists
      
      @todo_lists = end_of_association_chain
    end
end
