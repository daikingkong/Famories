class Public::MemoriesController < ApplicationController
  layout "public_application"

  def new
    @memory = Memory.new
  end

  def create
    memory = Memory.new(memory_params)
    memory.end_user_id = current_end_user.id
    memory.save
    @end_user = memory.end_user
    redirect_to end_user_path(@end_user)
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
  end

  def update
  end

  def destroy
  end

  def memory_params
    params.require(:memory).permit(:title, :memo, :end_user_id, :memory_image)
  end

end
