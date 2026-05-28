class OwnerPolicy < ApplicationPolicy
  def index?
    user.admin? || user.vet? || user.owner?
  end

  def show?
    if user.admin? || user.vet?
      true
    elsif user.owner?
      record.user_id == user.id
    else
      false
    end
  end

  def create?
    user.admin?
  end

  def update?
    if user.admin?
      true
    elsif user.owner?
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
      [:first_name, :last_name, :email, :phone, :address, :user_id]
    else
      [:first_name, :last_name, :email, :phone, :address]
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      elsif user.owner?
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end
end