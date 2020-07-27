Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do

    post '/suites/create_suite', to: 'suites#create_suite'
    post '/features/create_features', to: 'features#create_features'
    post '/requests/create_requests', to: 'requests#create_requests'

    resources :steps
    resources :scenarios
    resources :features
    resources :suites
    resources :assertions
    resources :requests
  end
end
