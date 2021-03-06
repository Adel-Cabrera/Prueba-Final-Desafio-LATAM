Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
    # omniauth_callbacks: 'users/omniauth_callbacks'
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  get 'filter', to: 'projects#filter', as: 'filter'

  resources :categories

  resources :projects do
      get 'page/:page', action: :index, on: :collection
    member do
      post 'add_tag'
      get 'all', to: 'projects#all', as: 'all'
      delete 'remove_tag/:category_id', to: 'projects#remove_tag', as: 'remove_tag'
    end
    # resources :tags
    resources :comments, only: [:create, :update, :destroy]
  end

  get 'users', to: 'users#all'
  get 'profile/:name', to: 'users#profile', as: 'profile'
  get 'display', to: 'projects#display'
  get 'about', to: 'informations#about'

  root to: 'projects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
