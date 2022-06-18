Rails.application.routes.draw do
  get 'authentication/login'
  get 'authentication/signup'
  get 'login/signup'
  resources :classrooms
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
