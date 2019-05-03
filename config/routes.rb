Rails.application.routes.draw do
  get 'challenge/new'
  get 'challenge/show'
  get 'challenge/index'
  get 'event/index'
  get 'event/show'
  get 'submissions/index'
  get 'submissions/new'
  get 'submissions/show'
  get 'submissions/makefav', as: :submissions_make_fav

  get 'signup', to: "users#new", as: :users_new
  get 'login', to: 'sessions#new', as: :sessions_new
  get 'logout', to: 'sessions#destroy', as: :sessions_destroy
  match "/auth" => "sessions#create", :via => :post, :as => :sessions_create
  match "/submit" => "submissions#create", :via => :post, :as => :submissions_create
  match 'challenge/create' => 'challenge#create', via: :post, as: :challenge_create
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
