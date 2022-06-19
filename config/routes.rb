Rails.application.routes.draw do
  post 'login', to: 'authentication#login'
  post 'signup', to: 'authentication#signup'
  
  resources :classrooms do
    resources :practices, only: [:create] do
      post 'verify_qr_code', to: 'practices#verification'
    end
  end

  get 'my_classrooms', to: 'classrooms#my_classrooms'
  match 'classrooms/:id/join', to: 'classrooms#join_classroom', via: [:post]
  match 'my_classrooms/:id/leave', to: 'classrooms#leave_classroom', via: [:post]
  
  resources :users
  resources :modalities, except: [:show, :update]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
