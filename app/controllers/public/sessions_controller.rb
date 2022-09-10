# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  layout "public_application"
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    guestuser = EndUser.guest
    sign_in guestuser
    redirect_to end_user_path(current_end_user), notice: 'ゲストユーザーでログインしました。'
  end

  def after_sign_in_path_for(resource)
    end_user_path(current_end_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end


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
end
