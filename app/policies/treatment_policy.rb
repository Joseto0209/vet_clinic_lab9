class TreatmentPolicy < ApplicationPolicy
  def create?
    if user.admin?
      true
    elsif user.vet?
      record.is_a?(Class) || record.appointment&.vet_id == user.vet_record&.id
    else
      false
    end
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def permitted_attributes
    if user.admin? || user.vet?
      [:name, :medication, :dosage, :clinical_notes, :administered_at]
    else
      []
    end
  end
end
