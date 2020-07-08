class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :username, presence: true, length: { maximum: 35 }
    validates :email, presence: true, length: { maximum: 200 }, uniqueness: { case_sensitive: false }

    has_many :recipes, dependent: :destroy #all recipes get destroyed!
    has_secure_password
    validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
end
