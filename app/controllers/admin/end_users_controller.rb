class Admin::EndUsersController < ApplicationController
  layout "admin_application"

  def index
    @end_users = EndUser.all
  end

  def show
  end

  def destroy
  end

end
