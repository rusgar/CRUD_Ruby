# Traductor del Idioma segun la localizacion del navegador, cambia la peticion al idioma correspondiente, leyendo la cabecera del HTTPS
class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include Language  
  include Pagy::Backend  
  include Error
end
