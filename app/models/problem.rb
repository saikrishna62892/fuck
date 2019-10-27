class Problem < ApplicationRecord
	
	belongs_to :user

	has_many :tags, dependent: :destroy
	has_many :solutions, dependent: :destroy 
	has_many :request_accesses, dependent: :destroy
	has_one_attached :attachment

	validates :prob_title, presence: true
	validates :prob_description, presence: true
<<<<<<< HEAD
	validates :prob_subject, presence: true
=======
	validates :prob_subject,presence:true
>>>>>>> 3655feb514f7e3a1f7181e7cbd25c8908fbbafc4


end
