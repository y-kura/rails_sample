Rails.application.routes.draw do


  resources :blogs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root 'test#index'
  root 'top#index'

  get 'test', to: 'test#index'
  get 'test/index', to: 'test#index'

  get 'test/show/:id', to: 'test#show'
  get 'test/image/:id', to: 'test#image'
  get 'test/add', to: 'test#add'
  post 'test/add', to: 'test#add'
  get 'test/edit/:id', to: 'test#edit'
  post 'test/edit/:id', to: 'test#edit'
  delete 'test/delete/:id', to: 'test#delete'

  get 'test/test', to: 'test#test'
  post 'test/test', to: 'test#test'

  get 'users/login', to: 'users#login'
  get 'users/logout', to: 'users#logout'
  post 'users/new', to: 'users#new'
  resources :users


end
