Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show, :update, :destroy] do
    resources :contacts, only: [:index, :create]
  end
  resources :contacts, only: [:index, :show, :update, :destroy]
  resource :contact_shares, only: [:create, :destroy]
end
