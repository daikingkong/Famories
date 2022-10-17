class Public::MemoryFavoritesController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @memory = Memory.find(params[:memory_id])
    @memory_favorite = current_end_user.memory_favorites.new(memory_id: @memory.id)
    @memory_favorite.save
  end

  def destroy
    @memory = Memory.find(params[:memory_id])
    @memory_favorite = current_end_user.memory_favorites.find_by(memory_id: @memory.id)
    @memory_favorite.destroy
  end

end
