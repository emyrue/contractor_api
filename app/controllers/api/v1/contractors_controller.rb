class Api::V1::ContractorsController < ApplicationController
  before_action :set_contractor, only: %i[show update destroy]

  # GET /contractors
  def index
    @contractors = Contractor.all

    render json: @contractors
  end

  # GET /contractors/1
  def show
    render json: @contractor
  end

  # POST /contractors
  def create
    @contractor = Contractor.new(contractor_params)

    if @contractor.save
      render json: @contractor, status: :created, location: @contractor
    else
      render json: @contractor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contractors/1
  def update
    if @contractor.update(contractor_params)
      render json: @contractor
    else
      render json: @contractor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contractors/1
  def destroy
    @contractor.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contractor
    @contractor = Contractor.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contractor_params
    params.require(:contractor).permit(:name, :rate, :bio)
  end
end
