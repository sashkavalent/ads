Ads::Application.routes.draw do
  root :to => 'ads#index'

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/profile', to: 'users#show'
  resources :ads do
      put 'change_state', :on => :member
  end

  devise_for :users, :controllers => { :users => "users" }

  resources :users
  resources :ads, except: [:new, :edit]
  resources :ad_types

end
