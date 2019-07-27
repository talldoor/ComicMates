class Article < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :comic_title, presence: true, length: { maximum: 30 }
  validates :comic_author, length: { maximum: 30 }
  validates :overview, presence: true, length: { maximum: 100 }
  validates :detail, length: { maximum: 400 }

  paginates_per 9

  scope :recent, -> { order(updated_at: :desc) }
end
