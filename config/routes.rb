Rails.application.routes.draw do
  get 'challenge/new'
  get 'challenge/index'
  get 'challenge/manage'
  get 'challenge/rejudge'
  get 'challenge/destroy'
  get 'challenge/log'
  get 'challenge/visualize'
  get 'challenge/get_info'
  get 'challenge/get_streams'
  match 'challenge/create' => 'challenge#create', via: :post, as: :challenge_create
  match 'challenge/receive_data' => 'challenge#receive_data', via: :post, as: :challenge_receive_data
  match 'challenge/update_status' => 'challenge#update_status', via: :post, as: :challenge_update_status

  get 'event/index'
  get 'event/rules'
  get 'event/statements'

  match 'judge/update_status' => 'judge#update_status', via: :post, as: :judge_update_status

  get 'submissions/index'
  get 'submissions/new'
  get 'submissions/make_used_for_tours'
  get 'submissions/source'
  get 'submissions/manage'
  get 'submissions/destroy'
  get 'submissions/make_opened'
  match "submissions/create" => "submissions#create", :via => :post, :as => :submissions_create

  get 'tournament/index'
  get 'tournament/new'
  get 'tournament/show'
  match "tournament/create" => "tournament#create", :via => :post, :as => :tournament_create

  get 'help', to: 'staticpages#help'

  get 'login', to: 'sessions#new', as: :sessions_new
  get 'logout', to: 'sessions#destroy', as: :sessions_destroy
  match "auth" => "sessions#create", :via => :post, :as => :sessions_create

  get 'users/new', to: "users#new", as: :users_new
  match "users/create" => "users#create", :via => :post, :as => :users_create

  root :to => redirect('/login')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  # New API for SPA frontend

  get 'api/submissions/', to: 'submissions#index_spa'
  get 'api/submissions/:id', to: 'submissions#show_spa'

  get 'api/event/rules', to: 'submissions#rules_spa'
  get 'api/event/statements', to: 'event#statements_spa'

  get 'api/challenges', to: 'challenge#index_spa'
  get 'api/challenges/:id', to: 'challenge#show_spa'

  get 'api/tournaments/', to: 'tournaments#index_spa'
  get 'api/tournaments/:id', to: 'tournaments#show_spa'

  match 'api/users/create', to: 'users#create_spa', via: :post
  match 'api/challenge/create', to: 'challenge#create_spa', via: :post
  match 'api/submissions/create', to: 'submissions#create_spa', via: :post
  match 'api/sessions/create', to: 'sessions#create_spa', via: :post
  match 'api/sessions/destroy', to: 'sessions#destroy_spa', via: :post

end
