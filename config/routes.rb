Rails.application.routes.draw do

  post "likes/:id/create" => "likes#create"
  post "likes/:id/destroy" => "likes#destroy"
  post "likes/:id/create_index" => "likes#create_index"
  post "likes/:id/destroy_index" => "likes#destroy_index"

  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  get "users/:id/show" => "users#show"
  post "users/:id/destroy" => "users#destroy"

  post "users/create" => "users#create"
  get "users/index" => "users#index"
  get "signup" => "users#new"
  get "login" => "users#login_form"
  post "login"  => "users#login"
  post "logout" => "users#logout"

  post "posts/checkoffer" => "posts#checkoffer"
  post "posts/offer" => "posts#offer"
  post "posts/destroyoffer" => "posts#destroyoffer"
  post "posts/acceptoffer" => "posts#acceptoffer"
  post "posts/destroyaccept" => "posts#destroyaccept"
  post "posts/destroymap" => "posts#destroymap"
  post 'posts/index' => "posts#index"
  get 'posts/index' => "posts#index"
  get 'posts/index' => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"


  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  post "posts/showshow" => "posts#showshow"

# トップ画面をtest4に変更中
  get '/' => "home#top"
  get "about" => "home#about"
  get "updates" => "home#updates"
  get "rates" => "home#rates"
  get 'test' => "home#test"
  get 'test2' => "home#test2"
  get 'test3' => "home#test3"
  get 'test4' => "home#test4"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
