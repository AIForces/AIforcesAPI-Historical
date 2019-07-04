Rails.application.routes.draw do
  get 'challenge/new'
  get 'challenge/index'
  get 'challenge/manage'
  get 'challenge/rejudge'
  get 'challenge/destroy'
  get 'challenge/log'
  get 'challenge/visualize'
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

  # New API for SPA frontend

  get 'api/submissions/', to: 'submissions#index_spa'
  get 'api/submissions/:id', to: 'submissions#show_spa'
  get 'api/submissions/public/:id', to: 'submissions#public'
  match 'api/submissions/create', to: 'submissions#create_spa', via: :post
  match 'api/submissions/:id/make_public', to: 'submissions#make_opened', via: :post
  match 'api/submissions/:id/make_primary', to: 'submissions#make_used_for_tours', via: :post

  get 'api/event/rules', to: 'event#rules_spa'
  get 'api/event/statements', to: 'event#statements_spa'
  get 'api/event/visualizer', to: 'event#visualizer_spa'
  get 'api/event/participants', to: 'event#participants'

  get 'api/challenges', to: 'challenge#index_spa'
  match 'api/challenges/create', to: 'challenge#create_spa', via: :post
  get 'api/challenges/:id', to: 'challenge#show_spa'
  get 'api/challenge/get_info', to: 'challenge#get_info'
  get 'api/challenge/get_streams', to: 'challenge#get_streams'

  get 'api/tournaments/', to: 'tournament#index_spa'
  get 'api/tournaments/:id', to: 'tournament#show_spa'

  match 'api/users/create', to: 'users#create_spa', via: :post
  get 'api/users/:id', to: 'users#show'

  match 'api/sessions/create', to: 'sessions#create_spa', via: :post
  match 'api/sessions/destroy', to: 'sessions#destroy_spa', via: :post
  match 'api/sessions', to: 'sessions#current', via: :get
end
