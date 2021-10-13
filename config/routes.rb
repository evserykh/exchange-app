Rails.application.routes.draw do
  resources :projects, only: :create, defaults: { format: 'json' }
end
