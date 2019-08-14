class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_one_attached :profile_image
  attribute :new_profile_image
  attribute :remove_profile_image, :boolean
  has_many :active_relationships,
           class_name: 'Relationship',
           foreign_key: 'follower_id',
           dependent: :destroy
  has_many :passive_relationships,
           class_name: 'Relationship',
           foreign_key: 'followed_id',
           dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :article
  has_many :comments, dependent: :destroy
  validates :name, presence: true, length: { maximum: 20 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  paginates_per 8
  scope :recent, -> { order(updated_at: :desc) }

  before_save do
    if new_profile_image
      self.profile_image = new_profile_image
    elsif remove_profile_image
      profile_image.purge
    end
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
