class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :username, presence: true, length: { maximum: 35 }
    validates :email, presence: true, length: { maximum: 200 }, uniqueness: { case_sensitive: false }

    has_many :recipes



end
