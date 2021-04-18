Rails.application.routes.draw do
  devise_for :users
  root 'user#welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "New_User" => "user#new"
  post "Create_User" => "user#register_user"
  get "Activate_User" => "user#activate_user"
  get "Log_in" => "authentication#log_in"
  post "auth_user" => "authentication#authenticate_user"
  get "Hello" => "login#hello"
  post "Log_In" => "login#sign_in"
  get "Forgot_Password" => "login#forgot_password"
  post "RP_token" => "login#rp_token"
  get "New_Password"     =>"login#new_password"
  post "Reset_Password" => "login#reset"
  post "Create_bus" => "booking#create_bus"
  get "Buses" => "booking#list"
  get "Book_Trip" => "booking#book_trip"
end
