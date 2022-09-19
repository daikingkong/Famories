class Admin::MemoryCommentsController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"

  def index
    @memory_comments = MemoryComment.page(params[:page]).per(20).order("created_at DESC")
  end

  def destroy
    memory_comment = MemoryComment.find(params[:id])
    memory_comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました。"
  end

end
