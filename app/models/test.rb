class Test < ApplicationRecord
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :name, presence: true, length: {maximum: 50}
	validates :description, presence: true, length: {maximum: 256}
	validates :path, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
	#format: {with: /\A(https?:\/\/)?([\w\.]+)\.([a-z]{2,6}\.?)(\/[\w\.]*)*\/?\z/}
end