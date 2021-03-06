Rails.application.routes.draw do
  resources :profiles
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "registrations",
    passwords: "password"
  }
  # adding custom urls in devise controller
  devise_scope :user do
    post "/user/check_availability/email",
         to:  "registrations#check_email_availabilty"
    get "user/signup", to:  "registrations#new"
    get "user/password/", to: "password#new", as: "forgot_password"
  end
  get "/stream", to: "profiles#live_streaming"
  get "admins/users", to: "admins#list"
  get "/admins/add_members", to: redirect("/admins/new")
  match "/admins/role_userole" => "admins#users", via: [:get, :post]
  match "/role_userole" => "admins#users", via: [:get, :post]
  resources :users
  resources :posts
  resources :admins
  post "check/to_delete_id/" => "admins#remove"
  post "admins/add_members" => "admins#add_members"
  get "/about_us/" => "aboutus#about_us"
  get "/contact_us" => "aboutus#contact_us"
  post "/profiles/user/role/:id" => "profiles#get_role"
  match "/admin_assign_roles" => "admins#admin_assign_roles", via: [:get, :post]
  match "/update" => "admins#bulk_user_update", via: [:post, :get]
  # You can have the root of your site routed with "root"
  # atch "/profiles/update/profile/pic" =>
  # profiles#update_profile_pic", via: [:get, :post], defaults: { format: "js" }
  patch "/update_profile_image", to: "profiles#update_profile_image"
  root "profiles#index"
  get "/admins/add_members", to: "admins#add_members"
  post "/profiles/getuser/image", to: "profiles#fb_image"
  post "/message/:id", to: "profiles#message"
  get "/chatroom",  to: "profiles#chat_api"
end
