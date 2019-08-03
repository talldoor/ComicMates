class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_one_attached :profile_image
  attribute :new_profile_image
  attribute :remove_profile_image, :boolean

  validates :name, presence: true, length: { maximum: 20 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save do
    if new_profile_image
      self.profile_image = new_profile_image
    elsif remove_profile_image
      profile_image.purge
    end
  end

  paginates_per 10

  scope :recent, -> { order(updated_at: :desc) }
end
