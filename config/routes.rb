Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }

  resources :users do
    resources :stocks
    resource  :user_follows
  end

  resources :tips do
    resources :comments, only: [ :create ]
  end
  get 'mine' => 'tips#mine', as: :mine
  get 'find_by_tags/:tag' => 'tips#find_by_tags', as: :find_by_tags

  resources :notifications, only: [ :index, :update ]

  root "tops#index"
end
