require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  test 'render a list of products' do
   get products_path
   
   assert_response :success
   assert_select '.product', 2
  end

  test ' render a detailed product page' do
    get product_path (products(:PS4))

    assert_response :success
    assert_select '.title', 'ps4 falla'
    assert_select '.description', 'esta en perfecto estado'
    assert_select '.price', '200€'
  end
   test 'render a new product form' do
   get new_product_path 

   assert_response :success
   assert_select 'form'
   end  

   test 'alow to create a new product' do
    post products_path, params: { 
        product:{
            title:'Nintendo',
            description:'le faltan los cables',
            price:'150'}
        }
        assert_redirected_to products_path
        assert_equal flash[:notice], 'Producto guardado corrrectamente'
    end
   
end
