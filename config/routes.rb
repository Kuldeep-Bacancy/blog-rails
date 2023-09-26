Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope :api do
    scope :v1 do
      post '/login', to: 'sessions#login'
      post '/signup', to: 'registrations#signup'
      delete '/logout', to: 'sessions#logout'
    end
  end
end
