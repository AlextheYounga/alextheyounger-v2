Rails.application.routes.draw do  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  if (Rails.env.production?)
    # match "*path" => redirect("https://www.alextheyounger.me/%{path}"), :constraints => { :protocol => "http://" }
    # match "*path" => redirect("https://www.alextheyounger.me/%{path}"), :constraints => { :subdomain => "" }
  end

  mount Ckeditor::Engine => "/ckeditor"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "pages#home"
  get "/resume" => "pages#resume"

  resources :users, except: [:signup]
<<<<<<< Updated upstream
  resources :articles, except: [:signup]
  resources :categories, except: [:destroy]
  resources :books, except: [:signup]
=======
  resources :books, except: [:signup, :show]
>>>>>>> Stashed changes
  resources :projects, except: [:signup]
  # resources :research, except: [:signup]
  resources :book_categories
  resources :posts, only: [:index]
  resources :stocks

  get "login" => "sessions#login"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  # get "resources", to: "pages#resources"
  # get "projects", to: "pages#projects"
  # get 'signup', to: 'users#signup'
  # get 'readinglist', to: 'pages#readinglist'
  # get "quotes", to: "pages#quotes"
  # get "about", to: "pages#about"
  # get "search_stocks", to: "stocks#search"

<<<<<<< Updated upstream
=======
  get '/books/reorder' => 'books#reorder'

  get 'login' => 'sessions#login'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
>>>>>>> Stashed changes
end
