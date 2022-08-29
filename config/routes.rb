Rails.application.routes.draw do
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users
  resources :users
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  get 'books' =>  'books#index'
  resources :books, only: [:create, :new, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :edit]
end
