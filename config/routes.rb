Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }

  resources :users, only: [ :show ] do
    resources :stocks, only: [ :create, :destroy]
    resource  :user_follows, only: [ :create, :destroy ]
    collection do
      get 'mypage'
    end
  end

  resources :tips do
    resources :comments, only: [ :create ]
    collection do
      get 'feed'
      get 'mine'
      get 'stocked'
      get 'followd_tags_with'
      get 'followd_users_with'
    end
  end

  resources :notifications, only: [ :index, :update ]
  resources :tags, only: [ :show ] do
    resource :tag_follows, only: [ :create, :destroy ]
  end

  root "tops#index"
end
