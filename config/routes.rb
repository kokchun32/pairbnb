Rails.application.routes.draw do

  get 'braintree/new'

  get 'welcome/index'

  # root 'clearance/sessions#new'
  root 'users#redirect_signed_in_users'
  # root 'welcome#index'

  resources :listings do
    resources :reservations
  end

  # namespace :listings do
  #   resources :reservations
  # end
  
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :index, :edit, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/homepage" => "users#homepage", as: "homepage"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # get "/listings/index" => "listings#index"#, as: 'index'
  get "/my_listing" => "listings#my_listing"
  get "/my_reservations" => "reservations#my_reservation", as: "my_reservations"
  get "/show_all_reservation" => "reservations#show_all_reservation"
  get "/admin_listing" => "listings#admin_listing", as: "admin_listing"
  # post 'braintree/new' => "braintree#checkout"
  post "/payment/reservations/:id" => "braintree#checkout"
  get "/payment/reservations/:id" => "reservations#payment", as: "payment"
end
