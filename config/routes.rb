Rails.application.routes.draw do
  get '/chat/:id' => "chats#show", as:"chat"
  resources :chats, only: [:create]

  get '/search' => "search#search"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "users#top"
  get "about" => "users#about"
  get "posts/:id/map" => "posts#map", as: "map"
  root "users#top"

  resources :users, only:[:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follows', as: 'follows'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :posts do
  	resource :post_comments, only:[:create, :destroy]
  	resource :favorites, only:[:create, :destroy]
  end

end
