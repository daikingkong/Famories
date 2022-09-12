class Admin::HomesController < ApplicationController
  layout "admin_application"

  def top
    @memories = Memory.all
  end

  def about
  end

end
