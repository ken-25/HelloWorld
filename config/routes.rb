Rails.application.routes.draw do
  get "/" => "home#top"
  get "about" => "home#about"
  get "admin" => "user#mg"

  resources :user
  get "login" => "user#login_form"
  post "login" => "user#login"
  get "logout" => "user#logout"

  resources :post


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
