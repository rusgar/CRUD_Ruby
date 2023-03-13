class ProductPolicy < BasePolicy

   def edit
    article.owner
   end
    
   def update
    article.owner
   end
   
   def destroy
    article.owner
   end
    
end    