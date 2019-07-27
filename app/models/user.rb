class User < ApplicationRecord
  has_many :articles, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true, length: { maximum: 20 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  paginates_per 5

  scope :recent, -> { order(updated_at: :desc) }
end
