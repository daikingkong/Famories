class Admin::GroupsController < ApplicationController
  layout "admin_application"

  def index
    @groups = Group.all
  end

  def show
  end

  def destroy
  end

end
