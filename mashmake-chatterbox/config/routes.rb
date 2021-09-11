Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'chatroom', to: 'chatroom#index'
  get 'signup', to: 'users#new'
  resources :users
  resources :messages
  mount ActionCable.server, at: '/cable'
end
