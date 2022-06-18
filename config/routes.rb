Rails.application.routes.draw do
  get 'login', to: 'authentication#login'
  get 'signup', to: 'authentication#login'
  resources :classrooms
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
