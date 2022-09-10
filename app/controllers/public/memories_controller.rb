class Public::MemoriesController < ApplicationController
  layout "public_application"

  def new
    @memory = Memory.new
  end

  def create
    memory = Memory.new(memory_params)
    memory.end_user_id = current_end_user.id
    if memory.save
      @end_user = memory.end_user
      redirect_to end_user_path(@end_user)
    else
      redirect_to new_memory_path
    end
  end

  def index
    @memories = Memory.page(params[:page]).per(6)
    @end_user = current_end_user
    @groups = @end_user.groups
  end

  def show
    @memory = Memory.find(params[:id])
    @memory_comments = @memory.memory_comments.page(params[:page]).per(8)
    @memory_comment = MemoryComment.new
  end

  def edit
    @memory = Memory.find(params[:id])
  end

  def update
    memory = Memory.find(params[:id])
    if memory.update(memory_params)
      redirect_to memory_path(memory), notice: "メモリーを編集しました。"
    else
      redirect_to edit_memory_path(memory), notice: "編集に失敗しました。"
    end
  end

  def destroy
    memory = Memory.find(params[:id])
    memory.destroy
    redirect_to end_user_path(current_end_user), notice: "削除に失敗しました。"
  end

  def memory_params
    params.require(:memory).permit(:title, :memo, :end_user_id, :memory_image)
  end

end
