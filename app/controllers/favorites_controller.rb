class FavoritesController < ApplicationController
    def index
       
    end    
    def create
       product.favorite!
       redirect_to product_path(product)
    end

    def destroy
       product.unfavorite!
       redirect_to product_path(product) , status: :see_other
    end

    private

    def product
        @product ||=Product.find(params[:product_id])   #Metodo de Memoization  en la cual se reduce el tiempo de ejecución de una función a cambio de ampliar el coste del espacio  
    end
    
end        