class FollowRequestPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def index?
    true
  end

  def create?
    record.follower == user
  end

  def update?
    record.user == user
  end

  def destroy?
    (record.follower == user) || (record.user == user)
  end

  relation_scope do |relation|
    relation.where(user: user)
  end
end
