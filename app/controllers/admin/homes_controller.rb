class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"

  def top
    @memories = Memory.page(params[:page]).per(24).order("created_at DESC")
  end

end
