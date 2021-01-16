Rails.application.routes.draw do
  get 'purchases/index'
  devise_for :users
  
  root to: "items#index" 

  resources :items, except: :index do
    resources :purchases, only: :index
  end
end
