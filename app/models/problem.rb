class Problem < ApplicationRecord
	has_many :tags, dependent: :destroy
	has_many :solutions, dependent: :destroy 
	has_many :request_accesses, dependent: :destroy
	has_one_attached :attachment

end
