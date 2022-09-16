class Admin::MemoriesController < ApplicationController
  before_action :authenticate_admin!
  
  layout "admin_application"

  def show
    @memory = Memory.find(params[:id])
    @memory_tags = @memory.memory_tags.page(params[:page]).per(5)
    @memory_comments = @memory.memory_comments.page(params[:page]).per(8)
  end

  def destroy
    memory = Memory.find(params[:id])
    memory.destroy
    redirect_to admin_end_user_path(memory.end_user_id)
  end

end
