class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :comic_image
  attribute :new_comic_image
  attribute :remove_comic_image, :boolean

  validates :comic_title, presence: true, length: { maximum: 30 }
  validates :comic_author, length: { maximum: 30 }
  validates :overview, presence: true, length: { maximum: 100 }
  validates :detail, length: { maximum: 400 }

  before_save do
    if new_comic_image
      self.comic_image = new_comic_image
    elsif remove_comic_image
      comic_image.purge
    end
  end

  paginates_per 9

  scope :recent, -> { order(updated_at: :desc) }
end
