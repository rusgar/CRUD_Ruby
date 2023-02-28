class ProductsController < ApplicationController
  def index
   @products = Product.all
  end 

  def show
    product   
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    # pp @product
    if @product.save
      redirect_to products_path, notice: 'Producto guardado correctamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    product
  end
  
  def update      
    if product.update (product_params)
      redirect_to products_path, notice: 'Tu producto se ha actualizado correctamente'
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    product.destroy 
    redirect_to products_path, notice: 'Tu producto se ha eliminado correctamente'
  end
  

  

    def product_params
     params.require(:product).permit(:title, :description, :price, :photo)  
    end
    
  
    private
    def product
    @product = Product.find(params[:id])

    end

end