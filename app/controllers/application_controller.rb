class ApplicationController < ActionController::Base
  add_flash_types :danger, :info, :warning, :success, :messages
  skip_before_action :authenticate_request, only: [:create], raise: false
  before_action :update_allowed_parameters, if: :devise_controller?

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded = jwt_decode(header)
    @curr_user = User.find(decoded[:user_id])
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[email name photo bio password password_confirmation]
    )
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[email name photo bio password password_confirmation]
    )
  end
end
