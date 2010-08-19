class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
    def public_access_to_list?
      @todo_list = TodoList.find(params[:id])
      unless @todo_list.public?
        flash[:alert] = "Your access to this list is forbidden"
        redirect_to root_path
      end
      
      
    end

end
