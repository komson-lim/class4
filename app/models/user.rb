class User < ApplicationRecord
    validates :email,  presence: true
    validates :name, length: {minimum:2, maximum:10}
    validates :email, uniqueness: true
    has_many :posts, dependent: :destroy
    has_secure_password
end
