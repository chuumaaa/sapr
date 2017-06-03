class Test < ApplicationRecord
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :name, presence: true, length: {maximum: 50}
	validates :description, presence: true, length: {maximum: 256}
	validates :path, presence: true
end
