class Location < ApplicationRecord
  belongs_to :user
  has_many :enquiries, dependent: :destroy

  has_many_attached :images, dependent: :purge_later
  has_one_attached :document, dependent: :purge_later
end
