class Admin::EndUsersController < ApplicationController
  layout "admin_application"

  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
    @user_groups = @end_user.groups
    @memories = @end_user.memories.page(params[:page]).per(10)
  end

  def destroy
    end_user = EndUser.find(params[:id])
    end_user.destroy
    redirect_to admin_end_users_path
  end

end
