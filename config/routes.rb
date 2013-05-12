Rawmedian::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  post 'send_mail', to: 'mail#contact'

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :videos, ActiveAdmin::Devise.config


  root :to => 'videos#index'

  get '/contact' => 'pages#contact', :as => :contact

  resources :videos
  resources :blogs
  get '/blog' => 'blogs#index', :as => :blogs
  
  ActiveAdmin.routes(self)
  
end
