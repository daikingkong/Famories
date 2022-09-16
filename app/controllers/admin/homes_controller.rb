class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  layout "admin_application"

  def top
    @memories = Memory.all
  end

end
