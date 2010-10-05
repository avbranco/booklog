Booklog::Application.routes.draw do

  devise_for :users
  
  resources :books do
    get 'fetch', :on => :collection
  end
  
  resources :readings do
    get 'book', :on => :member
  end
  
  root :to => "books#index"
end
