class Like < ApplicationRecord
  # validations
  validates :user_id,
    uniqueness: { scope: :post_id, message: "Post already liked" }

  # associations
  belongs_to :user
  belongs_to :post
end
