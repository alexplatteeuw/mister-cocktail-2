Rails.application.routes.draw do
  root to: 'cocktails#index'
  resources :cocktails, only: [:new, :create, :show, :index]
end
