Rails.application.routes.draw do
  
  devise_for :users
  resources :blogs
  
  root 'blogs#index'
  get '/my_blogs' =>"blogs#my_blogs"

  get 'blog/profile' => 'blogs#profile'
  get "/user/addfriend" => "blogs#friend"
  get "/user/acc" => "blogs#accept_friend"
  get "/user/de" => "blogs#delete_friend"

  

  resources :blogs, only: [] do
    member do
     get "like", to: "blogs#upvote"
     get "dislike", to: "blogs#downvote"
    end
  end
  resources :blogs, only: []  do 
    member do 
      get "follow", to: "blogs#follow" 
      get "unfollow", to: "blogs#unfollow" 
    end 
  end 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
