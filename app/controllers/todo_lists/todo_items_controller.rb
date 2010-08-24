class TodoLists::TodoItemsController < InheritedResources::Base
  respond_to :js, :except => 'create'
  respond_to :json, :only => 'create'
  belongs_to :todo_list
  
  def create
    create! do |success, failure|
      success.json do 
        render :json => resource
      end
      failure.json do 
        render :json => resource.error_hash , :status => 406
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
