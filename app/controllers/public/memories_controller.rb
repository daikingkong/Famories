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
  end

  def show
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
