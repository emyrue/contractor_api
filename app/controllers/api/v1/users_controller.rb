class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    bearer = request.headers['Authorization'].split[1]
    secret_key = Rails.application.credentials.fetch(:devise_jwt_secret_key)
    decoded = JWT.decode(bearer, secret_key).first
    @user = User.find(decoded['sub'].to_i)
    @users = User.includes(:contractor).all

    @all_users = []

    if @user.role == 'admin'
      @users.each do |user|
        contractor = Contractor.includes(:reviews).find(user.contractor.id) if user.contractor
        user_info = {
          **user.as_json,
          contractor: if contractor
                        {
                          **contractor.as_json,
                          rating: contractor.reviews.average(:rating) || 0,
                          number_of_reviews: contractor.reviews.length
                        }
                      else
                        {}
                      end
        }
        @all_users.push(user_info)
      end
    end

    render json: @all_users
  end

  # GET /users/1
  def show
    bearer = request.headers['Authorization'].split[1]
    secret_key = Rails.application.credentials.fetch(:devise_jwt_secret_key)
    decoded = JWT.decode(bearer, secret_key).first
    @user = User.includes(:contractor, :reservations).find(decoded['sub'].to_i)
    reservations = @user.reservations.includes(:contractor)
    @contractor = Contractor.includes(:reviews).find_by(user_id: @user.id) if @user.contractor
    @all_reservations = []
    reservations.each do |reservation|
      reservation_info = {
        **reservation.as_json,
        contractor: reservation.contractor
      }
      @all_reservations.push(reservation_info)
    end
    render json: {
      user: @user,
      contractor: if @contractor
                    {
                      **@contractor.as_json,
                      rating: @contractor.reviews.average(:rating) || 0,
                      number_of_reviews: @contractor.reviews.length
                    }
                  else
                    {}
                  end,
      reservations: @all_reservations
    }
  end

  # PATCH /users/1
  def update
    @my_user = User.includes(:contractor).includes(:reservations).find(@user.id)
    if user_params[:role] == Rails.application.credentials.fetch(:admin_code)
      @user.update(name: user_params[:name], role: 'admin')
    else
      @user.update(name: user_params[:name])
    end
    @contractor = Contractor.includes(:reviews).find_by(user_id: @my_user.id) if @my_user.contractor
    render json: {
      user: @user,
      contractor: if @contractor
                    {
                      **@contractor.as_json,
                      rating: @contractor.reviews ? @contractor.reviews.average(:rating) : 0,
                      number_of_reviews: @contractor.reviews ? @contractor.reviews.length : 0
                    }
                  else
                    {}
                  end,
      reservations: @my_user.reservations || []
    }
  end

  # DELETE /users/1
  def destroy
    bearer = request.headers['Authorization'].split[1]
    secret_key = Rails.application.credentials.fetch(:devise_jwt_secret_key)
    decoded = JWT.decode(bearer, secret_key).first
    @current_user = User.includes(:contractor).find(decoded['sub'].to_i)
    return unless (@user.id == @current_user.id) || (@current_user.role == 'admin')

    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :role, :picture_link, :signature, :public_id)
  end
end
