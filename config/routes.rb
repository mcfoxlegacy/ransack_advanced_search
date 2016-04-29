Rails.application.routes.draw do
  resources :saved_search, only: [:destroy]
end
