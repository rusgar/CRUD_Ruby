class ProductsController < ApplicationController
  def index
   @categories = Category.all.order(name: :asc).load_async
   @products = Product.all.order(created_at: :desc).load_async
   if params[:category_id]
    @products = @products.where(category_id: params[:category_id])
   end
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
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    product
  end
  
  def update      
    if product.update (product_params)
      redirect_to products_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    product.destroy 
    redirect_to products_path, notice: t('.destroyed')
  end
  

  

    def product_params
     params.require(:product).permit(:title, :description, :price, :photo, :category_id)  
    end
    
  
    private
    def product
    @product = Product.find(params[:id])

    end

end
