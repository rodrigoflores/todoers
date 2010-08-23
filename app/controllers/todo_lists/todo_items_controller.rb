class TodoLists::TodoItemsController < InheritedResources::Base
  respond_to :js
  respond_to :json, :only => 'create'
  belongs_to :todo_list
  
  def create
    create! do |success, failure|
      success.json { render :json => resource }
      failure.json do |format|
        render :json => [ resource.errors.map { |error| { :field => error.first, :description => error.last }} ] , :status => 406
      end
    end
  end
  
  def destroy
    destroy! do |format|
      format.js { render :nothing => true }
    end
  end 
  
  def complete
    resource.update_attributes({:done => true}) 
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end  
  
  protected
    def begin_of_association_chain
      current_user
    end
end
