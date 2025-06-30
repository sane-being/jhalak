class CommentPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def create?
    allowed_to?(:show?, record.post)
  end

  def destroy?
    (record.user == user)
  end

  relation_scope do |relation|
    posts = authorized_scope(Post.all)
    relation.where(post: posts)
  end
end
