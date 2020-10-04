Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home' => 'pages#home'

  get '/recipes' => 'recipes#index'
end
