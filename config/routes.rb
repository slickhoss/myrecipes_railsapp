Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home' => 'pages#home'
  
  resources :recipes, :chefs

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy' 

end
