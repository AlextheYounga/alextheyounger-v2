Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#home'
  get '/resume' => 'pages#resume'

  resources :users, except: [:signup]
  resources :books, except: [:signup, :show]
  resources :projects, except: [:signup]
  resources :book_categories

  get '/books/sort' => 'books#sort'
  post '/books/mass-sort' => 'books#mass_sort'

  get 'login' => 'sessions#login'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
