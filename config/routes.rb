# frozen_string_literal: true

Rails.application.routes.draw do
  # Auth routes
  get "/login", to: "auth/sessions#new", as: "login"
  post "/login", to: "auth/sessions#create"
  get "/logout", to: "auth/sessions#destroy", as: "logout"

  # Admin routes
  namespace :admin do
    resources :pages
    resources :snippets
    resources :article_categories
    resources :articles
    resources :product_categories
    resources :suppliers
    resources :products
    resources :project_categories
    resources :projects
    resources :activities, only: %i[index]
    resources :users
    resources :sortables, only: %i[create]
    resource :profile, only: %i[show update]
    root "dashboard#show"
  end

  # Public routes
  scope "(:locale)", locale: /en|el/ do
    resources :articles, only: [:index]
  end
  get "/:locale", to: "home#show", as: "home"
  root "home#show"
end
