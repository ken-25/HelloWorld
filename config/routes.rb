Rails.application.routes.draw do
  get "/" => "home#top"
  get "about" => "home#about"
  get "admin" => "user#mg"

  resources :user
  get "login" => "user#login_form"
  post "login" => "user#login"
  get "logout" => "user#logout"
  get "/user/:id/edit_password" => "user#edit_password"
  put "/user/:id/update_password" => "user#update_password"

  resources :post

  resources :like, only: [:update, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
