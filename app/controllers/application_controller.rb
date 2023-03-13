# Traductor del Idioma segun la localizacion del navegador, cambia la peticion al idioma correspondiente, leyendo la cabecera del HTTPS
class ApplicationController < ActionController::Base
  include Pagy::Backend

  class NotAuthorized < StandardError; end 

    rescue_from NotAuthorized do
      redirect_to products_path, alert: t('common.not_authorized')  
  end
      
  around_action :switch_locale
  before_action :set_current_user
  before_action :protect_pages

  def switch_locale(&action)
      I18n.with_locale(locale_from_header, &action)
  end
  
  private
  
  def locale_from_header
      request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end

  def set_current_user
     Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end  

  def protect_pages
     redirect_to new_session_path, alert: t('common.not_logged_in') unless Current.user
  end 
  
  def authorize! article = nil #(Es poco flexible y escalable(if and else))
    is_allowed =  "#{controller_name.singularize}Policy".classify.constantize.new(article).send(action_name)
   #is_allowed =  CategoryPolicy.new.index(configurar para llamar uno de la carpeta policies)
   raise NotAuthorized unless is_allowed
   #redirect_to products_path, alert: t('common.not_authorized') unless is_allowed
  end  
end
