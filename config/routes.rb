Rails.application.routes.draw do
  get 'submissions/', to: 'submissions#index'
  get 'submissions/:id', to: 'submissions#show'
  get 'submissions/public/:id', to: 'submissions#public'
  match 'submissions/create', to: 'submissions#create', via: :post
  match 'submissions/:id/make_public', to: 'submissions#make_opened', via: :post
  match 'submissions/:id/make_primary', to: 'submissions#make_used_for_tours', via: :post

  get 'event/rules', to: 'event#rules_spa'
  get 'event/statements', to: 'event#statements_spa'
  get 'event/visualizer', to: 'event#visualizer_spa'
  get 'event/participants', to: 'event#participants'

  get 'challenges', to: 'challenge#index'
  match 'challenges/create', to: 'challenge#create', via: :post
  get 'challenges/:id', to: 'challenge#show'
  get 'challenge/get_info', to: 'challenge#get_info'
  get 'challenge/get_streams', to: 'challenge#get_streams'

  get 'tournaments/', to: 'tournament#index'
  get 'tournaments/:id', to: 'tournament#show'

  match 'users/create', to: 'users#create', via: :post
  get 'users/:id', to: 'users#show'

  match 'sessions/create', to: 'sessions#create', via: :post
  match 'sessions/destroy', to: 'sessions#destroy', via: :post
  match 'sessions', to: 'sessions#current', via: :get
end
