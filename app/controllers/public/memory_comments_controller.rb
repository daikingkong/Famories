class Public::MemoryCommentsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_guest_user

  def create
    @memory = Memory.find(params[:memory_id])
    @memory_comments = @memory.memory_comments.page(params[:page]).per(10).order("created_at DESC")
    @memory_comment = MemoryComment.new(memory_comment_params)
    @memory_comment.end_user_id = current_end_user.id
    @memory_comment.memory_id = @memory.id
    @memory_comment.save
  end

  def destroy
    @memory = Memory.find(params[:memory_id])
    @memory_comments = @memory.memory_comments.page(params[:page]).per(10).order("created_at DESC")
    @memorycomment = MemoryComment.find(params[:id])
    @memorycomment.destroy
    # redirect_to memory_path(@memory),  notice: "コメントを削除しました。"
  end

  private

  def memory_comment_params
    params.require(:memory_comment).permit(:comment, :memory_id, :end_user_id)
  end

end
