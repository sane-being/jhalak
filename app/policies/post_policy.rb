class PostPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies
  
  def show?
    (user.id == record.user_id) || (record.user.followers.include? user)
  end

  def edit?
    user.id == record.user_id
  end

  def update?
    user.id == record.user_id
  end
  
  def destroy?
    user.id == record.user_id
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping

  relation_scope do |relation|
    relation.where(user_id: user.following.ids + [user.id])
  end
end
