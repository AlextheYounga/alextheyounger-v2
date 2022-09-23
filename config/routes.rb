Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#home'
  get '/resume' => 'pages#resume'

  resources :users, except: [:signup]
  resources :books, except: [:signup]
  resources :projects, except: [:signup]
  resources :book_categories

  get 'login' => 'sessions#login'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
