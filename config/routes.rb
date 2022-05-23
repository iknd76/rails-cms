# frozen_string_literal: true

Rails.application.routes.draw do
  get "/login", to: "auth/sessions#new", as: "login"
  post "/login", to: "auth/sessions#create"
  get "/logout", to: "auth/sessions#destroy", as: "logout"

  namespace :admin do
    resources :activities, only: %i[index]
    resources :users
    resource :profile, only: %i[show update]
    root "dashboard#show"
  end

  root "home#show"
end
