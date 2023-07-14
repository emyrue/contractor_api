class Api::V1::ContractorsController < ApplicationController
  before_action :set_contractor, only: %i[show update destroy]

  # GET /contractors
  def index
    @contractors = Contractor.includes(:reviews).all

    @all_contractors = []

    @contractors.each do |contractor|
      contractor_info = {
        **contractor.as_json,
        rating: contractor.reviews.average(:rating)
      }
      @all_contractors.push(contractor_info)
      puts contractor_info
    end

    render json: @all_contractors
  end

  # GET /contractors/1
  def show
    @my_contractor = Contractor.includes(:reservations).includes(:reviews).find(@contractor.id)
    reservations = @my_contractor.reservations.includes(:user)
    @all_reservations = []
    reservations.each do |reservation|
      reservation_info = {
        **reservation.as_json,
        user: reservation.user
      }
      @all_reservations.push(reservation_info)
    end
    render json: {
      contractor: {
        **@contractor.as_json,
        rating: @my_contractor.reviews.average(:rating)
      },
      reservations: @all_reservations,
      reviews: @my_contractor.reviews,
    }
  end

  # POST /contractors
  def create
    @contractor = Contractor.new(contractor_params)

    if @contractor.save
      render json: @contractor, status: :created
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
    params.require(:contractor).permit(:user_id, :name, :rate, :job_title, :bio)
  end
end
