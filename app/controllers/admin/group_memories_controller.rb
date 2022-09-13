class Admin::GroupMemoriesController < ApplicationController
  layout "admin_application"

  def index
    @memories = GroupMemory.page(params[:page]).per(10)
  end

  def show
    @memory = GroupMemory.find(params[:id])
    @group = @memory.group
  end

  def destroy
    memory = GroupMemory.find(params[:id])
    memory.destroy
    redirect_to admin_group_memories_path
  end

end
