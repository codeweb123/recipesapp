class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :username, presence: true, length: { maximum: 35 }
    validates :email, presence: true, length: { maximum: 200 }, uniqueness: { case_sensitive: false }

    has_many :recipes, dependent: :destroy #all recipes get destroyed!
    has_secure_password
    validates :password, presence: true, length: { minimum: 5 }
    has_many :comments, dependent: :destroy
    has_many :recipe_ingredients
    require 'securerandom'

    def self.create_with_omniauth(auth_hash)
        create! do |user|
          user.provider = auth_hash["provider"]
          user.uid = auth_hash["uid"]
          user.username = auth_hash["info"]["name"]
          user.email = auth_hash[:info][:email]
          user.password = SecureRandom.urlsafe_base64
        end
    end
end
