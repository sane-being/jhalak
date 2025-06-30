class Post < ApplicationRecord
  # validations
  validates :content, presence: true
  validates :images, presence: true

  # associations
  belongs_to :user
  has_many_attached :images
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
end
