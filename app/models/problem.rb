class Problem < ApplicationRecord
	has_many :tags, dependent: :destroy 
	has_one_attached :attachment
end
