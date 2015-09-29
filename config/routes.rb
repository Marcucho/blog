Rails.application.routes.draw do

  resources :tags

  devise_for :users
  resources :articles do
    resources :comments, only: [:create, :destroy, :update]
  end

  root 'welcome#index'

  get "/dashboard", to: "welcome#dashboard"

  put "/articles/:id/publish", to: "articles#publish"

end
