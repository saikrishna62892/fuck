class User < ApplicationRecord

	has_one_attached :avatar
	has_many :solutions, dependent: :destroy
	has_many :request_accesses, dependent: :destroy
	has_secure_password
end
