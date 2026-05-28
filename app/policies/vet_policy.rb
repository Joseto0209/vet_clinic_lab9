class VetPolicy < ApplicationPolicy
  def index?
    user.admin? || user.vet? || user.owner?
  end

  def show?
    user.admin? || user.vet? || user.owner?
  end

  def create?
    user.admin?
  end

  def update?
    if user.admin?
      true
    elsif user.vet?
      record.user_id == user.id
    else
      false
    end
  end

  def destroy?
    user.admin?
  end

  def permitted_attributes
    if user.admin?
      [:first_name, :last_name, :email, :phone, :specialization, :user_id]
    elsif user.vet?
      [:first_name, :last_name, :email, :phone, :specialization]
    else
      []
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet? || user.owner?
        scope.all
      else
        scope.none
      end
    end
  end
end