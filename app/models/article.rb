class Article < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  validates :comic_title, presence: true, length: { maximum: 30 }
  validates :comic_author, length: { maximum: 30 }
  validates :overview, presence: true, length: { maximum: 100 }
  validates :detail, length: { maximum: 400 }
end
