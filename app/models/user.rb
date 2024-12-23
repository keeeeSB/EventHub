class User < ApplicationRecord
  has_many :events,    dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :joins,     dependent: :destroy
  has_many :reviews,   dependent: :destroy

  has_secure_password
  mount_uploader :profile_image, ProfileImageUploader

  validates :name,     presence: true
  validates :email,    presence: true
  validates :password, presence: true, length: { minimum: 6 }
end
