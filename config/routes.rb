Rawmedian::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :videos, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root :to => "home#index"
end
