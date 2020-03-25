Rails.application.routes.draw do
  get "posts/index" => "post#index"
  get "posts/new" => "post#new"
  post "posts/create" => "post#create"
  get "posts/:id" => "post#show"
  get "posts/:id/edit" => "post#edit"
  get "/" => "home#top"
  get "about" => "home#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
