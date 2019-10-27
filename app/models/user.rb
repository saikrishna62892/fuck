class User < ApplicationRecord

	has_one_attached :avatar
	has_many :solutions, dependent: :destroy
	has_many :request_accesses, dependent: :destroy
	has_many :problems, dependent: :destroy
	has_secure_password

	validates :username, presence: true,length: { maximum: 30 }
	validates :dob, presence: true
	validates :email, presence: true
	validates :gender, presence: true
	validates :firstname, presence: true
	validates :avatar, :presence => true
end
