Rails.application.routes.draw do
  devise_for :users
  root 'user#welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "Create_User" => "user#register_user"
  get "Activate_User" => "user#activate_user"
  post "auth_user" => "authentication#authenticate_user"
  post "Log_In" => "login#sign_in"
end
