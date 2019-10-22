class Solution < ApplicationRecord
	has_one_attached :attachment
	belongs_to :problem
	belongs_to :user
end
