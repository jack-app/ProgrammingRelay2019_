Rails.application.routes.draw do
  resources :wikis , param: :title
  post "wiki/search" => "wikis#search"
  get "/" => "wikis#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
