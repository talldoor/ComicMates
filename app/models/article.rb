class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :comic_image
  attribute :new_comic_image
  attribute :remove_comic_image, :boolean
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  validates :comic_title, presence: true, length: { maximum: 30 }
  validates :comic_author, length: { maximum: 30 }
  validates :overview, presence: true, length: { maximum: 100 }
  validates :detail, length: { maximum: 400 }

  paginates_per 9
  scope :recent, -> { order(updated_at: :desc) }

  before_save do
    if new_comic_image
      self.comic_image = new_comic_image
    elsif remove_comic_image
      comic_image.purge
    end
  end

  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def like?(user)
    liked_users.include?(user)
  end
end
