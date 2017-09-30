Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/bugs', to: 'bugs#index', as: 'bugs'
      post '/bugs', to: 'bugs#create'
      get '/bugs/:application_token/:number', to: 'bugs#show', as: 'bug'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
