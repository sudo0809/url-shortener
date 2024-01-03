Rails.application.routes.draw do
  root to: "main#index"
  devise_for :users


  # resource :app do
  #   resource :user
  #   resource :login
  # end

  get '/my-urls', to: 'short_urls#show'
  post '/create-short-url', to: 'short_urls#create'
  get '/view/:url_hex', to: 'short_urls#view'
  get '/url/expired', to: 'short_urls#expired_url', as: 'expired_url'
  get '/:short_url_uniq_hex', to: 'short_urls#redirect_url'

  #
  # get '/app/signup', to: 'users#signup'
  # post 'app/create-user', to: 'users#create_user'
  #
  # get 'app/login', to: 'sessions#get_login'
  # post 'app/login', to: 'sessions#login'
  #
  # get 'app/user/:id', to: 'users#index'



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

end
