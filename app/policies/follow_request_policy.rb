class FollowRequestPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def update?
    record.user == user
  end

  def destroy?
    (record.follower == user) || (record.user == user)
  end

  relation_scope do |relation|
    relation.where(user: user).or(relation.where(follower: user))
  end
end
