Rails.application.routes.draw do
  root "home#top"
  get "about" => "home#about"
  get "admin" => "users#mg"

  resources :users do
    resource :password, only:[:edit, :update]
  end
  get "a" => "password#edit"

  get "login" => "users#login_form"
  post "login" => "users#login"
  get "logout" => "users#logout"

  resources :posts

  resources :likes, only: [:update, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
