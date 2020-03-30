Rails.application.routes.draw do
  get "users/index" => "user#index"
  get "users/new" => "user#new"
  post "users/create" => "user#create"

  get "posts/index" => "post#index"
  get "posts/new" => "post#new"
  post "posts/create" => "post#create"
  get "posts/:id" => "post#show"
  get "posts/:id/edit" => "post#edit"
  post "posts/:id/update" => "post#update"
  post "posts/:id/destroy" => "post#destroy"

  get "/" => "home#top"
  get "about" => "home#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
