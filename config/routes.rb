Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
   get '/articulos/new', to:'articulos#new', as: :new_articulo
   get '/articulos', to:'articulos#index'
   get '/articulos/:id', to: 'articulos#show', as: :articulo
   
end