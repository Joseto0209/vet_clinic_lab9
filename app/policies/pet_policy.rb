class PetPolicy < ApplicationPolicy
  def index?
    user.admin? || user.vet? || user.owner?
  end

  def show?
    if user.admin? || user.vet?
      true
    elsif user.owner? && user.owner_record.present?
      record.owner_id == user.owner_record.id
    else
      false
    end
  end

  def create?
    user.admin? || user.owner?
  end

  def update?
    if user.admin?
      true
    elsif user.owner? && user.owner_record.present?
      record.owner_id == user.owner_record.id
    else
      false
    end
  end

  def destroy?
    update?
  end

  def permitted_attributes
    if user.admin?
      [:name, :species, :breed, :date_of_birth, :weight, :photo, :owner_id]
    elsif user.owner?
      [:name, :species, :breed, :date_of_birth, :weight, :photo]
    else
      []
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      elsif user.owner? && user.owner_record.present?
        scope.where(owner_id: user.owner_record.id)
      else
        scope.none
      end
    end
  end
end