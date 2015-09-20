Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  resources :tips do
    resources :comments, only: [ :create ]
  end
  get 'mine' => 'tips#mine', as: :mine

  root "tops#index"
end
