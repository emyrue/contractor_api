class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def respond_with(_resource, _opts = {})
    if current_user
      @user = User.includes(:contractor).includes(:reservations).find(current_user.id)
      render json: {
        message: 'Logged.',
        data: { user: current_user,
                contractor: @user.contractor,
                reservations: @user.reservations }
      }, status: :ok
    else
      redirect_to Rails.application.credentials.fetch(:frontend_app_url)
    end
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             Rails.application.credentials.fetch(:devise_jwt_secret_key)).first
    current_user = User.find(jwt_payload['sub'])
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: 'Logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Logged out failure.' }, status: :unauthorized
  end
end
