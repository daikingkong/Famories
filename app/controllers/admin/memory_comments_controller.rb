class Admin::MemoryCommentsController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"

  def index
    @memory_comments = MemoryComment.order("created_at DESC")
  end

  def destroy
    @memory_comments = MemoryComment.order("created_at DESC")
    memory_comment = MemoryComment.find(params[:id])
    @memory = memory_comment.memory
    memory_comment.destroy
    # redirect_to request.referer, notice: "コメントを削除しました。"
  end

end
