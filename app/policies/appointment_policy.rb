class AppointmentPolicy < ApplicationPolicy
  def index?
    user.admin? || user.vet? || user.owner?
  end

  def show?
    if user.admin?
      true
    elsif user.vet?
      record.vet_id == user.vet_record&.id
    elsif user.owner?
      record.pet&.owner_id == user.owner_record&.id
    else
      false
    end
  end

  def create?
    if user.admin?
      true
    elsif user.vet?
      record.is_a?(Class) || record.vet_id == user.vet_record&.id
    elsif user.owner?
      record.is_a?(Class) || (record.pet && record.pet.owner_id == user.owner_record&.id)
    else
      false
    end
  end

  def update?
    if user.admin?
      true
    elsif user.vet?
      record.vet_id == user.vet_record&.id
    elsif user.owner?
      record.pet&.owner_id == user.owner_record&.id
    else
      false
    end
  end

  def destroy?
    update?
  end

  def permitted_attributes_for_create
    if user.admin?
      [:pet_id, :vet_id, :date, :reason, :status]
    elsif user.vet?
      [:pet_id, :date, :reason, :status]
    elsif user.owner?
      [:pet_id, :vet_id, :date, :reason, :status]
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.admin?
      [:pet_id, :vet_id, :date, :reason, :status]
    elsif user.vet?
      [:pet_id, :date, :reason, :status]
    elsif user.owner?
      [:vet_id, :date, :reason, :status]
    else
      []
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.vet? && user.vet_record.present?
        scope.where(vet_id: user.vet_record.id)
      elsif user.owner? && user.owner_record.present?
        scope.joins(:pet).where(pets: { owner_id: user.owner_record.id })
      else
        scope.none
      end
    end
  end
end
