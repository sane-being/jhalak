class LikePolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies
  #
  def index?
    allowed_to?(:show?, record.last.post)
  end

  def create?
    allowed_to?(:show?, record.post)
  end

  def destroy?
    allowed_to?(:show?, record.post) && (record.user == user)
  end

  relation_scope do |relation|
    posts = authorized_scope(Post.all)
    relation.where(post: posts)
  end
end
