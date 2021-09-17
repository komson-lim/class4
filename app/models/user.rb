class User < ApplicationRecord
    validates :email,:pass,  presence: true
    validates :name, length: {minimum:2, maximum:10}
    validates :email, uniqueness: true
    has_many :posts
end
