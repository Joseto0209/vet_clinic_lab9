class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def index
    @pets = policy_scope(Pet).includes(:owner)
  end

  def show
    authorize @pet
  end

  def new
    @pet = Pet.new
    authorize @pet
  end

  def create
    @pet = Pet.new(permitted_attributes(Pet))
    authorize @pet
    # Explicitly set owner to the user's owner record if they are an owner role.
    # We do this because owner_id might be omitted by permitted_attributes, or not, but it's safe to enforce here if missing.
    @pet.owner_id = current_user.owner_record.id if current_user.owner? && current_user.owner_record.present? && @pet.owner_id.nil?

    if @pet.save
      redirect_to @pet, notice: "Pet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @pet
  end

  def update
    authorize @pet
    if @pet.update(permitted_attributes(@pet))
      redirect_to @pet, notice: "Pet was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @pet
    @pet.destroy
    redirect_to pets_path, notice: "Pet was successfully deleted."
  end

  private

  def set_pet
    @pet = Pet.includes(:appointments).find(params[:id])
  end
end