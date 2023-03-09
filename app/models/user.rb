class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true
              format: { 
                with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
              message: :invalid
        }
    validates :username, presence: true, uniqueness: true,
               length: {in: 3..15},
               format: { 
                with: /\A[a-z-0-9-A-Z]+\z/,
                message: :invalid
                }

    validates :password, length: {minimum:3, maximum:8}

    before_save :down_case_attributes

    private

    def down_case_attributes
        self.username= username.downcase
        self.email= email.downcase

    end    

end
