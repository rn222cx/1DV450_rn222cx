class UserPolicy < ApplicationPolicy
  def show?
    return true if user.admin?
    true if record.us == user.id
  end

  def create?
    true if user.admin?
    true if record.id == user.id
  end

  def update?
    true if user.admin?
    true if record.id == user.id
  end

  def destroy?
    true if user.admin?
    true if record.id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end