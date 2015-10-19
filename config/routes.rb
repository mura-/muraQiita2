Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }

  get 'users/mypage' => 'users#mypage', as: :users_mypage
  resources :users, only: [ :show ] do
    resources :stocks, only: [ :create, :destroy]
    resource  :user_follows, only: [ :create, :destroy ]
  end

  get 'tips/followed_tags_with' => 'tips#followed_tags_with', as: :tips_followed_tags_with
  get 'tips/followed_users_with' => 'tips#followed_users_with', as: :tips_followed_users_with
  get 'tips/feed' => 'tips#feed', as: :tips_feed
  get 'tips/mine' => 'tips#mine', as: :tips_mine
  get 'tips/stocked' => 'tips#stocked', as: :tips_stocked
  resources :tips do
    resources :comments, only: [ :create ]
  end

  get 'find_by_tags/:tag' => 'tips#find_by_tags', as: :find_by_tags

  resources :notifications, only: [ :index, :update ]
  resources :tags, only: [ :show ] do
    resource :tag_follows, only: [ :create, :destroy ]
  end

  root "tops#index"
end
