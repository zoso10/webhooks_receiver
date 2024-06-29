# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  post "rubygems" => "rubygems#create"

  get "up" => "rails/health#show", as: :rails_health_check
end
