Rails.application.routes.draw do
  
  devise_for :users
  resources :blogs
  
  root 'blogs#index'
  get '/my_blogs' =>"blogs#my_blogs"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
