Rawmedian::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :videos, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root :to => 'videos#index'

  get '/contact' => 'pages#contact', :as => :contact

  resources :videos
  resources :blogs
  get '/blog' => 'blogs#index', :as => :blogs
  
end
