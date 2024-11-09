class User < ApplicationRecord
  has_many :events, dependent: :destroy

  has_secure_password
  mount_uploader :profile_image, ProfileImageUploader

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
