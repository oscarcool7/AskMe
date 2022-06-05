Rails.application.routes.draw do
  root to: "questions#index"

  resources :hashtags, only: %i[show]
  resources :questions
  resource :session, only: %i[create destroy new]
  resources :users, except: %i[index]
end
