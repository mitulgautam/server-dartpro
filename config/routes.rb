Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  resources :players, only: %i[index create]
  resources :games, only: %i[index create show]
  post '/score' => 'scores#update_score'
end
