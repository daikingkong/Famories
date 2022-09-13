class Admin::GroupMemoriesController < ApplicationController
  layout "admin_application"

  def index
    @memories = GroupMemory.page(params[:page]).per(10)
  end

  def show
  end

  def destroy
  end

end
