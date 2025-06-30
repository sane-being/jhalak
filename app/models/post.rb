class Post < ApplicationRecord
  # validations
  validates :content, presence: true

  # associations
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
end
