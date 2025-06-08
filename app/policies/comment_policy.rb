class CommentPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def create?
    allowed_to?(:show?, record.post)
  end

  def destroy?
    allowed_to?(:show?, record.post) && (record.user == user)
  end
end
