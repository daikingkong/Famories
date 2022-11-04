class Public::MemoryCommentsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_guest_user

  def create
    @memory = Memory.find(params[:memory_id])
    @memory_comments = @memory.memory_comments
    @memory_comment = MemoryComment.new(memory_comment_params)
    @memory_comment.end_user_id = current_end_user.id
    @memory_comment.memory_id = @memory.id
    @memory_comment.save
  end

  def destroy
    @memory = Memory.find(params[:memory_id])
    @memory_comments = @memory.memory_comments
    @memory_comment = MemoryComment.find(params[:id])
    if @memory_comment.end_user_id == current_end_user.id
      @memory_comment.destroy
    else
      redirect_to memory_path(@memory), alert: '自分のメモリーの以外は編集できません'
    end
  end

  private


  def memory_comment_params
    params.require(:memory_comment).permit(:comment, :memory_id, :end_user_id)
  end

end
