class ArticulosController < ApplicationController
   def index
     @articulos = Articulo.all
   end 

   def show
    @articulo = Articulo.find(params[:id])
    
    end

    def new
        @articulo = Articulo.new
    end

    def create
        @articulo = Articulo.new(articulo_params)

        if @articulo.save
            redirect_to articulos_path, notice: 'Zapatilla guardada correctamente'
        else
            render :new, status: :unprocessable_entity
        end
    end
   
    private

    def articulo_params
        params.require(:articulo).permit(:title, :description, :price)
      
    end
end