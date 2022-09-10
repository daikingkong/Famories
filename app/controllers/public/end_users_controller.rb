class Public::EndUsersController < ApplicationController
  layout "public_application"

  def show
    @end_user = EndUser.find(params[:id])
    @user_groups = @end_user.groups.page(params[:page]).per(10)
    @memories = @end_user.memories.page(params[:page]).per(6)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    end_user = EndUser.find(params[:id])
    end_user.update(end_user_params)
    redirect_to end_user_path(end_user)
  end

  def destroy
    end_user = EndUser.find(params[:id])
    end_user.destroy
    redirect_to thanks_path
  end

  def unsubscribe_confirm
    @end_user = EndUser.find(params[:end_user_id])
  end

  def thanks
  end

  def favorite_memories
    @end_user = current_end_user
    @user_groups = @end_user.groups
     # ログインユーザーの「いいねしたメモリー一覧」を表示するため
    favorite_memories = MemoryFavorite.where(end_user_id: @end_user.id).pluck(:memory_id)
    @memories = Memory.find(favorite_memories)
    @memories = Kaminari.paginate_array(@memories).page(params[:page]).per(6)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :email, :profile_image)
  end

end
