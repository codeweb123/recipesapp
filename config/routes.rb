Rails.application.routes.draw do
  #root "pages#home"
  get 'pages/home', to: 'pages#home'
  
  #get "/auth/:provider/callback" => "sessions#create"
  #get "/signout" => "sessions#destroy", :as => :signout
 
  #get 'auth/github', as: "login"
  root to: "users#new"
  get '/auth/:provider/callback', to: 'sessions#omnicreate'

  resources :recipes, shallow: true do
    resources :comments, only: [:create, :index, :new] # nested routes 
  end

  get '/signup', to: 'users#new'
  resources :users, except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
#3 routes for login feature
  resources :ingredients, except: [:destroy]

  resources :recipe_ingredients, only: [:new, :create, :show] 

  resources :recipes do
    resources :recipe_ingredients, only: [:new, :create, :show]
  end
  
end
