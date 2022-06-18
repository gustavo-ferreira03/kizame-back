Rails.application.routes.draw do
  post 'login', to: 'authentication#login'
  post 'signup', to: 'authentication#signup'
  resources :classrooms
  resources :users
  resources :modalities, except: [:show, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
