Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/', to: "pages#index"
  root to: "products#index"

  resources :products

  # member
  get "sign_up", to: "users#sign_up"
  post "/account_verify", to: "users#account_verify"

  get "/sign_in", to: "users#sign_in"
  post "/create_session", to: "users#create_session"
  
  delete "/sign_out", to: "users#sign_out"

end
