Rails.application.routes.draw do
  root to: "questions#index"

  resources :questions
  resource :session, only: %i[create destroy new]
  resources :users, only: %i[create destroy edit new update]
end
