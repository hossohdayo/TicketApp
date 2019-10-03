Rails.application.routes.draw do
  get 'user/new'
  get 'user/index'
  post 'user/new' => 'user#create'
  get 'user/edit/:id' => 'user#edit'
  patch 'user/edit/:id' => 'user#update'
  delete 'user/destroy/:id' => 'user#destroy'
  get 'user/:id' => 'user#show'

  get 'ticket/index'
  get 'ticket/new' => 'ticket#new'
  post 'ticket/new' => 'ticket#create'
  get 'ticket/edit/:id' => 'ticket#edit'
  patch 'ticket/edit/:id' => 'ticket#update'
  delete 'ticket/destroy/:id' => 'ticket#destroy'
  get 'ticket/:id' => 'ticket#show'

  get 'login/index'
  post 'login/auth'
  get 'login/logout'

  post 'like/create' => 'like#create'
  delete 'like/destroy/:id' => 'like#destroy'
  get 'like/:id' => 'like#index'
end
