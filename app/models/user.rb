class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validations
  validates :username, presence: true, uniqueness: true

  # associations
  has_many :follow_requests,
    dependent: :destroy
  has_many :accepted_follow_requests,
    -> { where accepted: true },
    foreign_key: :user_id,
    class_name: "FollowRequest",
    dependent: :destroy
  has_many :followers,
    through: :accepted_follow_requests,
    source: :follower

  has_many :sent_follow_requests,
    foreign_key: :follower_id,
    class_name: "FollowRequest",
    dependent: :destroy
  has_many :accepted_sent_follow_requests,
    -> { where accepted: true },
    foreign_key: :follower_id,
    class_name: "FollowRequest",
    dependent: :destroy
  has_many :following,
    through: :accepted_sent_follow_requests,
    source: :user

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :profile_picture do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 40, 40 ]
    attachable.variant :small, resize_to_limit: [ 150, 150 ]
    attachable.variant :medium, resize_to_limit: [ 300, 300 ]
  end
end
