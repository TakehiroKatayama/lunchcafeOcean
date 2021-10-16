Rails.application.routes.draw do
  root 'static_pages#home'
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  get 'shop', to: 'static_pages#shop'
end
