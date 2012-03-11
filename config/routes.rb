Pitchin::Application.routes.draw do

  resources :events do
    resources :needs
    resources :signups
  end
  
  authenticated :user do
    root :to => 'home#index'
  end
  
  root :to => "home#index"
  
  devise_for :users
  
  resources :users, :only => :show
  
end
