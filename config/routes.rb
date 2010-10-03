Booklog::Application.routes.draw do
  get "readings/index"

  get "readings/new"

  get "readings/create"

  get "readings/update"

  devise_for :users
  resources :books do
    get 'fetch', :on => :collection
  end
  root :to => "books#index"
end
