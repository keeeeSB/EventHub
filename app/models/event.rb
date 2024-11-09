class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :category

  validates :title,       presence: true
  validates :description, presence: true
  validates :start_time,  presence: true
  validates :location,    presence: true
end
