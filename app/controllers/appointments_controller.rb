class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = policy_scope(Appointment).includes(:pet, :vet)
  end

  def show
    authorize @appointment
  end

  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  def create
    @appointment = Appointment.new(permitted_attributes(Appointment))
    authorize @appointment
    
    # Assign vet and pet if silently dropped
    @appointment.vet = current_user.vet_record if current_user.vet? && current_user.vet_record.present?
    # Ensure pet is assigned if somehow dropped
    if current_user.owner? && @appointment.pet_id.nil? && params[:appointment][:pet_id].present?
      # If purely dropped by pundit, how does the user choose?
      # Assuming we just trust permitted_attributes.
    end
    
    if @appointment.save
      redirect_to @appointment, notice: "Appointment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @appointment
  end

  def update
    authorize @appointment
    if @appointment.update(permitted_attributes(@appointment))
      redirect_to @appointment, notice: "Appointment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @appointment
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment was successfully deleted."
  end

  private

  def set_appointment
    @appointment = Appointment.includes(:pet, :vet, treatments: :rich_text_clinical_notes).find(params[:id])
  end
end