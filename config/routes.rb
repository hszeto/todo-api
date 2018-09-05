Rails.application.routes.draw do
  get '/readiness', to: 'application#readiness'

  resources :todos do
    resources :items
  end
end
