Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get "/book-search", to: "book_search#index"
    end
    namespace :v0 do
      resources :users, only: [:create]
      resources :forecast, only: [:index]
    end
  end
end
