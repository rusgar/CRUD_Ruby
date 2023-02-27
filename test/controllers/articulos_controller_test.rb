 require 'test_helper'

class ArticulosControllerTest < ActionDispatch::IntegrationTest

  test 'renderice la tienda de articulos' do
    get articulos_path
   
    assert_response :success
    assert_select '.articulo', 2
  
  end

  test ' renderizar los detalles de cada articulos' do
      get articulo_path (articulos(:Adidas))

      assert_response :success
      assert_select '.title', 'superboost'
      assert_select '.description', 'suela ergomica ajustable'
      assert_select '.price', '100€'
      
  end
  
end
