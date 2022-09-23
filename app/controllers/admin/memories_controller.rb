class Admin::MemoriesController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"

  def show
    @memory = Memory.find(params[:id])
    @memory_tags = @memory.memory_tags
    @memory_comments = @memory.memory_comments.page(params[:page]).per(8).order("created_at DESC")
  end

  def destroy
    memory = Memory.find(params[:id])
    memory.destroy
    redirect_to admin_end_user_path(memory.end_user_id), notice: "メモリーを削除しました。"
  end

end
