class Users::TodoListsController < ApplicationController
  inherit_resources
  actions :index, :show
  respond_to :js, :only => [:watch_todo_list, :unwatch_todo_list]
  belongs_to :user
  
  before_filter :authenticate_user!, :only => [:watch_todo_list, :unwatch_todo_list]
  
  def watch_todo_list
    resource.users << current_user
    render :nothing => true 
  end
  

  
  def show
    show! do |format|
      format.html do 
        unless resource.reachable?(current_user) 
          flash[:alert] = "You are not allowed to see this list"
          redirect_to root_path
        end
      end
    end
  end
  
  protected
    def collection
      @todo_lists = parent.todo_lists.public
    end
end
