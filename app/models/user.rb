class User < ApplicationRecord
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: {maximum: 50}
	validates :email, presence: true, uniqueness: { case_sensitive: false}, 
					  format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
	has_secure_password
	validates :password, length: { minimum: 6 }
end
