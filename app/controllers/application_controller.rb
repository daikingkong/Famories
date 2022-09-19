class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  end

  def ensure_guest_user
    if current_end_user.email == "guest@example.com"
      redirect_to end_user_path(current_end_user), alert: 'ゲストユーザーは『閲覧』『いいね』のみ可能です。'
    end
  end

end
