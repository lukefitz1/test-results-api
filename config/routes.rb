Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do

    post '/features/create_features', to: 'features#create_features'

    resources :steps
    resources :scenarios
    resources :features
  end
end
