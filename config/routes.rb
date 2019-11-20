Rails.application.routes.draw do
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
