class Public::MemoryFavoritesController < ApplicationController

  def create
    memory = Memory.find(params[:memory_id])
    memory_favorite = current_end_user.memory_favorites.new(memory_id: memory.id)
    memory_favorite.save
    redirect_to memory_path(memory)
  end

  def destroy
    memory = Memory.find(params[:memory_id])
    memory_favorite = current_end_user.memory_favorites.find_by(memory_id: memory.id)
    memory_favorite.destroy
    redirect_to memory_path(memory)
  end

end
