AppName::Application.routes.draw do
  get "pages/index"

  devise_for :users
  
  resources :users, :only => :show do
    resources :todo_lists, :controller => 'users/todo_lists' do
      put :watch_todo_list, :on => :member
    end
  end

  root :to => 'pages#index'
  
  resources :todo_lists do
    delete :unwatch_todo_list, :on => :member
    resources :todo_items, :controller => 'todo_lists/todo_items' do
      put :complete, :on => :member
    end
  end

end
