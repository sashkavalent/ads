Ads::Application.routes.draw do
  get "omniauth_callbacks/facebook"

  get "omniauth_callbacks/vkontakte"

  root :to => 'ads#index'

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'

  resources :ads, except: [:new, :edit] do
    resources :comments, :only => :create
    put 'change_state', :on => :member
  end

  resources :comments, :only => :destroy

  devise_for :users, :controllers => { :users => "users",
      :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:index, :destroy, :show, :update]
  resources :ad_types, only: [:create, :destroy, :index]

end
