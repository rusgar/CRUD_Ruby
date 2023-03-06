class ProductsController < ApplicationController
  def index
   @categories = Category.order(name: :asc)
   @pagy , @products= pagy_countless(FindProducts.new.call(params), items:12) 

   #Refactorizamos el codigo en find_products.rb
    
   #@products = Product.with_attached_photo
    #   order_by= Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
    #   @products = @products.order(order_by) 

    # if params[:category_id]
    #  @products = @products.where(category_id: params[:category_id])
    # end

    # if params[:min_price].present?
    #   @products = @products.where("price >= ?", params[:min_price])
    # end

    # if params[:max_price].present?
    #   @products = @products.where("price <= ?", params[:max_price])
    # end
    # order_by= Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
    # @products = @products.order(order_by) 
   # @pagy, @products = pagy_countless(@products, items:5)
  #  if params[:query_text].present?
  #     @products = @products.search_full_text(params[:query_text]) #( la query del text me sale en la url, segun el metodo post, pero se la carga en la busqueda)
  #  end
    
    
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
