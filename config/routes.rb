Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/', to: "pages#index"
  root to: "pages#index"
  get '/test', to: "pages#test"

end
