class ProductsController < ApplicationController
  def index
   @categories = Category.all.order(name: :asc)
   @products = Product.all.order(created_at: :desc)
   @pagy = pagy_countless(@products, items:5) 
   if params[:category_id]
    @products = @products.where(category_id: params[:category_id])
   end
   if params[:min_price].present?
     @products = @products.where("price >= ?", params[:min_price])
   end
   if params[:max_price].present?
    @products = @products.where("price <= ?", params[:max_price])
   end
   orders_by= Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
      #@products = @products.order(order_by) #(Errores pues no me busca y el metodo es incorrecto)   
    
  # if params[:query_text].present?
  #   @products = @products.search(params[:query_text]) #( la query del text me sale en la url, segun el metodo post, pero se la carga en la busqueda)
  # end
    
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
