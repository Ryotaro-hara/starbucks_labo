Rails.application.routes.draw do
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: [:show, :edit, :update]
  resources :posts do
    collection do
      get "page/:page", action: :index
      get :seasonal, action: :seasonal
      get 'search'
    end
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
