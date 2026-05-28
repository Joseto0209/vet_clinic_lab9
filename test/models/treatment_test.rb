require "test_helper"

class TreatmentTest < ActiveSupport::TestCase
  def setup
    @treatment = Treatment.new(
      appointment: appointments(:one),
      name: "Blood Test",
      medication: "N/A",
      dosage: "N/A",
      administered_at: Time.current
    )
  end

  test "valid treatment can be saved" do
    assert @treatment.valid?
  end

  test "name is required" do
    @treatment.name = nil
    assert_not @treatment.valid?
    assert_includes @treatment.errors[:name], "can't be blank"
  end

  test "administered_at is required" do
    @treatment.administered_at = nil
    assert_not @treatment.valid?
    assert_includes @treatment.errors[:administered_at], "can't be blank"
  end

  test "appointment is required" do
    @treatment.appointment = nil
    assert_not @treatment.valid?
    assert_includes @treatment.errors[:appointment], "must exist"
  end
end
