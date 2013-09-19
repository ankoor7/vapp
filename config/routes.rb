Vapp::Application.routes.draw do

  resources :groups do
    resources :events, only: [:new, :create]
    resources :users, only: [] do
      member do
        post 'suspend'
        post 'unsuspend'
      end
    end
  end

  resources :events, only: [:index, :show, :edit, :update, :destroy]
  resources :users, only: [:show]

  resources :groups_leaders, only: [] do
    member do
      post 'invite'
      post 'uninvite'
      post 'apply'
    end
  end

  resources :events_volunteers, only: [] do
    member do
      post 'register'
      post 'unregister'
    end
  end

  devise_for :users, :controllers => { registrations: :registrations, sessions: :sessions }
  devise_scope :user do
    get "/search_users", :to => "users#search"
    get "/account", :to => "users#account"
    get "/dashboard", :to => "users#dashboard"
  end


  get "/landing", :to => "home#landing"
  get "/home", :to => "home#index"
  root :to => "home#landing"

  match 'search', to: 'home#search', via: [:get, :post], as: :search

end
