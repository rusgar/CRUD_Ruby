module Authorization
    extend ActiveSupport::Concern
  
    included do
        class NotAuthorized < StandardError; end 

        rescue_from NotAuthorized do
           redirect_to products_path, alert: t('common.not_authorized')  
        end
  
      private
  
      def authorize! article = nil #(Es poco flexible y escalable(if and else))
        is_allowed =  "#{controller_name.singularize}Policy".classify.constantize.new(article).send(action_name)
       #is_allowed =  CategoryPolicy.new.index(configurar para llamar uno de la carpeta policies)
        raise NotAuthorized unless is_allowed
       #redirect_to products_path, alert: t('common.not_authorized') unless is_allowed
      end 
    end
  end