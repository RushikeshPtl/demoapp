Rails.application.routes.draw do
  devise_for :users
  root 'user#welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "New_User" => "user#new"
  post "Create_User" => "user#register_user"
  get "Activate_User" => "user#activate_user"
  get "User_Profile" => "user#user_profile"
  get "Edit_User" => "user#edit_user"
  patch "Update_User" => "user#update_user"
  get "Log_in" => "authentication#log_in"
  post "auth_user" => "authentication#authenticate_user"
  get "Log Out" => "authentication#log_out"
  get "Hello" => "login#hello"
  post "Log_In" => "login#sign_in"
  get "Forgot_Password" => "login#forgot_password"
  post "RP_token" => "login#rp_token"
  get "New_Password"     =>"login#new_password"
  post "Reset_Password" => "login#reset"
  get "Add_Bus" => "booking#add_bus"
  post "Create_bus" => "booking#create_bus"
  get "Buses" => "booking#list"
  get "Book_Trip" => "booking#book_trip"
  post "Initiate_Booking" => "booking#initiate_booking"
  get "Show Details" => "booking#show_details"
  get "Confirm_Booking" => "booking#confirm_booking"
  get "Find_Bookings" => "booking#find_bookings"
  get "Cancel_Booking" => "booking#cancel_booking"
end
