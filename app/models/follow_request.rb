class FollowRequest < ApplicationRecord
  # validations
  validates :user_id,
    uniqueness: { scope: :follower_id, message: "Request already sent" },
    comparison: { other_than: :follower_id, message: "Can't follow yourself" }

  # associations
  belongs_to :user
  belongs_to :follower, class_name: "User"
end
