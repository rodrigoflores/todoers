class UsersController < ApplicationController
  inherit_resources 
  actions :show
  
  def resource
    @user = end_of_association_chain.find(params[:id])
    @todo_lists = @user.todo_lists
  end
end
