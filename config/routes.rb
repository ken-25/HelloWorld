Rails.application.routes.draw do
  root "home#top"
  get "about" => "home#about"
  get "admin" => "users#mg"

  resources :users do
    resource :password, only:[:edit, :update]
    collection do
      post :login
      get :login_form
      get :logout
    end
  end

  resources :posts

  resources :likes, only: [:update, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
