Rails.application.routes.draw do
  get 'challenge/new'
  get 'challenge/show'
  get 'challenge/index'
  get 'challenge/log'
  get 'challenge/visualize'
  match 'challenge/create' => 'challenge#create', via: :post, as: :challenge_create

  get 'event/index'
  get 'event/show'

  get 'judge/send_data'
  match 'judge/receive_data' => 'judge#receive_data', via: :post, as: :judge_receive_data

  get 'submissions/index'
  get 'submissions/new'
  get 'submissions/show'
  get 'submissions/make_used_for_ch'
  get 'submissions/make_used_for_tours'
  get 'submissions/source'
  match "/submit" => "submissions#create", :via => :post, :as => :submissions_create

  get 'help', to: 'staticpages#help'
  get 'rules', to: 'staticpages#rules'
  get 'statements', to: 'staticpages#statements'

  get 'signup', to: "users#new", as: :users_new
  get 'login', to: 'sessions#new', as: :sessions_new
  get 'logout', to: 'sessions#destroy', as: :sessions_destroy
  match "/auth" => "sessions#create", :via => :post, :as => :sessions_create
  root :to => redirect('/login')
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
