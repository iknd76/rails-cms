# frozen_string_literal: true

Rails.application.routes.draw do
  get "/login", to: "auth/sessions#new", as: "login"
  post "/login", to: "auth/sessions#create"
  get "/logout", to: "auth/sessions#destroy", as: "logout"

  namespace :admin do
    resources :pages
    resources :snippets
    resources :article_categories
    resources :articles
    resources :product_categories
    resources :suppliers
    resources :products
    resources :activities, only: %i[index]
    resources :users
    resources :sortables, only: %i[create]
    resource :profile, only: %i[show update]
    root "dashboard#show"
  end

  root "home#show"
end
