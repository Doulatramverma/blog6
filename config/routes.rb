Rails.application.routes.draw do
  
  devise_for :users
  resources :blogs
  
  root 'blogs#index'
  get '/my_blogs' =>"blogs#my_blogs"

  get 'blog/profile' => 'blogs#profile'
  
  #get "/blogs/profile" => "blogs#show"
  get "/blog/addfriend" => "blogs#friend"
  get "/blog/acc" => "blogs#accept_friend"
  get "/blog/de" => "blogs#delete_friend"

  # resources :blogs do
  #   member do
  #   get "profile", to: "blogs#profile"
  #   get "addfriend", to: "blogs#friend"
  #   get "accept", to: "blogs#accept_friend"
  #   get "delete", to: "blogs#delete_friend"
  #   end
  # end

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
