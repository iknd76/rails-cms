# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    root "dashboard#show"
  end

  root "home#show"
end
