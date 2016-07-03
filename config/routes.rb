Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    post 'downgrade'
  end
  resources :wikis

  resources :wikis do
    resources :collaborators, only:[:new, :create, :destroy]
  end
  resources :charges, only: [:new, :create]

  root 'welcome#index'
end
