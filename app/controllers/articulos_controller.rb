class ArticulosController < ApplicationController
    def index
        @articulos = Articulo.all
    end 
end