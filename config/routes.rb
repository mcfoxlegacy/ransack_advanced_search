Rails.application.routes.draw do
  resources :saved_searches, only: [:destroy]
end
