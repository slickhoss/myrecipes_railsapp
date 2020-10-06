Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home' => 'pages#home'
  
  resources :recipes, :chefs
end
