class Picture < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user

  validates :content, presence: true, length: { in: 1..140 }
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
