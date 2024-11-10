class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :favorites, dependent: :destroy
  has_many :joins,     dependent: :destroy
  has_many :reviews,   dependent: :destroy

  accepts_nested_attributes_for :category, reject_if: ->(attributes){ attributes['name'].blank? }

  validates :title,       presence: true
  validates :description, presence: true
  validates :start_time,  presence: true
  validates :location,    presence: true

  # 開催日時が過ぎていないイベント
  scope :upcoming, -> { where('start_time >= ?', Time.current) }

  # 開催日時が過ぎたイベント
  scope :past, -> { where('start_time < ?', Time.current) }
end
