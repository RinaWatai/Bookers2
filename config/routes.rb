Rails.application.routes.draw do
resources :post_images, only: [:new, :index, :show]
  root to: 'homes#top'
  devise_for :users
 get "/homes/about" => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
