class Users::TodoListsController < ApplicationController
  inherit_resources
  actions :index, :show, :new
  belongs_to :user
  
  def new
    new! do |format|
      format.html do 
        unless resource.user == current_user
          flash[:alert] = "You are not allowed to create a list as this uer"
          redirect_to root_path
        end
      end
    end
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
      #Criar Named Scope ?
    end
end
