class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
