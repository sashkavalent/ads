Ads::Application.routes.draw do

  root :to => 'ads#index'

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'

  resources :ads do
    resources :comments, :only => :create
    put 'change_state', :on => :member
  end

  resources :comments, :only => :destroy

  devise_for :users, :controllers => { :users => "users",
      :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:index, :destroy, :show, :update]

  resources :ad_types, only: [:create, :destroy, :new]
  resources :places, only: [:create, :destroy, :new]
  resources :currencies, only: [:create, :destroy, :new]

  resources :sections, only: [:create, :destroy, :new] do
    resources :subsections, only: [:create, :new]
  end
  resources :subsections, only: [:destroy]

  resources :announcements, only: [:index, :destroy] do
    delete 'clear', :on => :collection
  end

end
