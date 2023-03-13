class BasePolicy
    attr_reader :article

    def initialize(article)
        @article = article    
    end 

    def method_missing(m, *args, &block)
        false
    end
end    