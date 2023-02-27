class ProductsController < ApplicationController
  def index
   @products = Product.all
  end 

  def show
    @product = Product.find(params[:id])
    
  end
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    # pp @product
    if @product.save
      redirect_to products_path, notice: 'Producto guardado corrrectamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  
  end
  

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  
  end
    
  
  

end
