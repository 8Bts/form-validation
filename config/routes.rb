Rails.application.routes.draw do
  root 'authors#new'
  resources :authors, only: [:new, :create]
end
