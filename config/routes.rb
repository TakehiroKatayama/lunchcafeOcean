Rails.application.routes.draw do
  root 'static_pages#home'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  get 'shop', to: 'static_pages#shop'

  resources :reservations, only: %i[index create]
  post 'reservations/confirm'
  post 'reservations/back'

  resources :contacts, only: %i[index create]
  post 'contacts/confirm'
  post 'contacts/back'

  resources :users, only: %i[new create]
  get '/mypage', to: 'users#show'
  get '/mypage/edit', to: 'users#edit'
  patch '/mypage/edit', to: 'users#update'
  post 'users/confirm'
  post 'users/back'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :password_resets, only: %i[new create edit update]

  resources :news, only: %i[index show]
  resources :menus, only: %i[index]

  namespace :admin do
    root 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    post 'guest_login', to: 'user_sessions#guest_login'
    delete 'logout', to: 'user_sessions#destroy'
    resources :news
    resources :menus
    resources :users, only: %i[index show edit update destroy]
    resources :reservations
    patch '/reservations/cancel/:id', to: 'reservations#cancel', as: :cancel
    patch '/reservations/status/:id', to: 'reservations#status_update', as: :status
    resources :contacts, only: %i[index show update destroy]
    resources :capacities, only: %i[index show edit update]
    patch '/capacities/closed/:id', to: 'capacities#closed', as: :closed
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
