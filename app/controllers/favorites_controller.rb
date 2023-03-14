class FavoritesController < ApplicationController
    def create
       Favorite.create(product: product,user: Current.user)
       redirect_to product_path(product)
    end

    def destroy
       product.favorites.find_by(user: Current.user).destroy
       redirect_to product_path(product) , status: :see_other
    end

    private

    def product
        @product ||=Product.find(params[:product_id])   #Metodo de Memoization  en la cual se reduce el tiempo de ejecución de una función a cambio de ampliar el coste del espacio  
    end
    
end        