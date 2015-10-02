Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }

  resources :users, only: [ :show ] do
    resources :stocks, only: [ :create, :desroy]
    resource  :user_follows, only: [ :create, :destroy ]
  end

  resources :tips do
    resources :comments, only: [ :create ]
  end

  get 'mine' => 'tips#mine', as: :mine
  get 'find_by_tags/:tag' => 'tips#find_by_tags', as: :find_by_tags

  resources :notifications, only: [ :index, :update ]
  resources :tags, only: [ :show ] do
    resource :tag_follows, only: [ :create, :destroy ]
  end

  root "tops#index"
end
