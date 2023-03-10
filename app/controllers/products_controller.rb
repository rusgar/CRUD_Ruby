class ProductsController < ApplicationController
  skip_before_action :protect_pages, only: [:index, :show]
  def index
   @categories = Category.order(name: :asc).load_async
   @pagy , @products= pagy_countless(FindProducts.new.call(product_params_index), items: 8)

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
    # @product = Current.user.products.new(product_params) (Una manera haciendo scopeding)
    @product = Product.new(product_params)
    # pp @product
    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! product    
  end

  def update
    authorize! product
    if product.update (product_params)
      redirect_to products_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! product
    product.destroy
    redirect_to products_path, notice: t('.destroyed'), status: :see_other
  end


  private

  def product_params
     params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end

  def product_params_index
    params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page)
  end
  
  def product
    @product = Product.find(params[:id])
  end

end
