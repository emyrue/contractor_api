class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    bearer = request.headers['Authorization'].split[1]
    secret_key = Rails.application.credentials.fetch(:devise_jwt_secret_key)
    decoded = JWT.decode(bearer, secret_key).first
    @user = User.includes(:contractor).find(decoded['sub'].to_i)
    render json: {
      user: @user,
      contractor: @user.contractor
    }
  end

  # PATCH /users/1
  def update
    @my_user = User.includes(:contractor).find(1)
    @user.update(user_params)
    render json: {
      user: @user,
      contractor: @my_user.contractor
    }
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :role, :is_contractor)
  end
end
