class StoryPolicy < ApplicationPolicy

  def create?
    true if user.admin?
    true if record.user_id == user.id
  end

  def update?
    true if user.admin?
    true if record.user_id == user.id
  end

  def destroy?
    true if user.admin?
    true if record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end