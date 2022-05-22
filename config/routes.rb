# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    root "dashboard#show"
  end

  root "home#show"
end
