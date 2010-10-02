Booklog::Application.routes.draw do
  devise_for :users
  resources :books do
    get 'fetch', :on => :collection
  end
  root :to => "books#index"
end
