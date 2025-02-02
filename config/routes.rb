Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'games#show'
  # Blackjack
  get 'blackjack', to: 'blackjack#index'
  post '/start_game', to: 'blackjack#start_game'
  post '/new_card', to: 'blackjack#new_card'
  post '/bank_new_card', to: 'blackjack#bank_new_card'
  # Longest Word
  get 'longest_word', to: 'longest_word#index'
  post '/new', to: 'longest_word#new'
  post "score", to: "longest_word#score"
end
