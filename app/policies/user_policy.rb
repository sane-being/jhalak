class UserPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def index?
    true
  end

  def followers_index?
    true
  end

  def following_index?
    true
  end

  def show?
    true
  end

  def edit?
    # here we can access our context and record
    user.id == record.id
  end

  def update?
    # here we can access our context and record
    user.id == record.id
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping

  relation_scope do |relation|
    relation.all
  end
end
