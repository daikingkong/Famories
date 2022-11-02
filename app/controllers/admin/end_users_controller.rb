class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"

  def index
    @end_users = EndUser.page(params[:page]).per(20).order("created_at DESC")
  end

  def show
    @end_user = EndUser.find(params[:id])
    @user_groups = @end_user.groups
    @memories = @end_user.memories.page(params[:page]).per(12)
  end

  def destroy
    end_user = EndUser.find(params[:id])
    end_user.destroy
    redirect_to admin_end_users_path, notice: "会員を削除しました。"
  end

end
