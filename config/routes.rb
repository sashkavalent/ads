Ads::Application.routes.draw do
  root :to => 'ads#index'

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/profile', to: 'users#show'

  resources :ads, except: [:new, :edit] do
      put 'change_state', :on => :member
  end

  devise_for :users, :controllers => { :users => "users" }

  resources :users, only: [:index, :destroy, :show, :update]
  resources :ad_types, only: [:create, :destroy, :index]

end
