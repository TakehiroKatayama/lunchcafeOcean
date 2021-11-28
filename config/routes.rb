Rails.application.routes.draw do
  root 'static_pages#home'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  get 'shop', to: 'static_pages#shop'

  resources :reservations, only: %i[index create]

  resources :users, only: %i[new create]
  get '/mypage', to: 'users#show'
  get '/mypage/edit', to: 'users#edit'
  patch '/mypage/edit', to: 'users#update'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :news, only: %i[index show]

  namespace :admin do
    root 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :news
    resources :users, only: %i[index show edit update destroy]
    resources :reservations
  end
end
