Ads::Application.routes.draw do

  root :to => 'ads#index'

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'

  resources :ads, except: :new do
    resources :comments, :only => :create
    put 'change_state', :on => :member
  end

  resources :comments, :only => :destroy

  devise_for :users, :controllers => { :users => "users",
      :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:index, :destroy, :show, :update]

  resources :ad_types, only: [:create, :destroy, :index]
  resources :places, only: [:create, :destroy, :index]
  resources :currencies, only: [:create, :destroy, :index]

  resources :sections, only: [:create, :destroy, :index] do
    resources :subsections, only: [:create, :index]
  end
  resources :subsections, only: [:destroy]

end
