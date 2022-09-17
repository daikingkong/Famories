class Admin::GroupMemoriesController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"

  def index
    @memories = GroupMemory.page(params[:page]).per(12).order("created_at DESC")
  end

  def show
    @memory = GroupMemory.find(params[:id])
    @group = @memory.group
  end

  def destroy
    memory = GroupMemory.find(params[:id])
    memory.destroy
    redirect_to admin_group_memories_path, notice: "グループのメモリーを削除しました。"
  end

end
