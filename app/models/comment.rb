class Comment < ApplicationRecord
  # validations
  validates :content, presence: { message: "Post can't be blank" }

  # associations
  belongs_to :post
  belongs_to :user
end
