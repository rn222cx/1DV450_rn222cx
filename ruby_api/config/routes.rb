require 'api_constraints'

Rails.application.routes.draw do
  
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  namespace :api, defaults: {format: :json},
            constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :stories
    end
  end

  # Without api as subdomain
  namespace :api, defaults: {format: :json} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :stories
    end
  end

  
  resources :stories
  resources :users
  resources :domains, except: [:edit, :update]
  

  root 'sessions#new'

end
