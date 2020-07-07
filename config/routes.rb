Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do

    post '/features/create_features', to: 'features#create_features'
    post '/requests/create_requests', to: 'requests#create_requests'

    resources :steps
    resources :scenarios
    resources :features
    resources :assertions
    resources :requests
  end
end
