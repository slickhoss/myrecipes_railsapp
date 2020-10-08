Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home' => 'pages#home'
  
  resources :recipes do
    resources :comments, only: [:create]
  end
  resources :chefs, :ingredients, :messages

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy' 

  mount ActionCable.server => '/cable'
  get '/chat' => 'chatrooms#show'
end
