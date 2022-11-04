class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!, except: [:thanks]
  before_action :ensure_guest_user, only: [:edit, :update, :destroy, :unsubscribe_confirm]
  before_action :ensure_correct_end_user, except: [:favorite_memories, :unsubscribe_confirm, :thanks]

  layout "public_application"

  def show
    @end_user = current_end_user
    @user_groups = @end_user.groups
    @memories = @end_user.memories.page(params[:page]).per(12)
  end

  def edit
    @end_user = current_end_user
  end

  def update
    end_user = current_end_user
    end_user.update(end_user_params)
    redirect_to end_user_path(end_user), notice: '会員情報を更新しました。'
  end

  def destroy
    end_user = current_end_user
    end_user.destroy
    redirect_to thanks_path
  end

  def unsubscribe_confirm
    @end_user = current_end_user
  end

  def thanks
  end

   # ログインユーザーの「いいねしたメモリー一覧」を表示するため
  def favorite_memories
    @end_user = current_end_user
    @user_groups = @end_user.groups
    favorite_memories = MemoryFavorite.where(end_user_id: @end_user.id).pluck(:memory_id)
    @memories = Memory.find(favorite_memories)
    @memories = Kaminari.paginate_array(@memories).page(params[:page]).per(12)
  end

  private

  def ensure_correct_end_user
    end_user = EndUser.find(params[:id])
    unless end_user == current_end_user
      redirect_to end_user_path(current_end_user), alert: '本人のみ利用可能です。'
    end
  end

  def end_user_params
    params.require(:end_user).permit(:name, :email, :profile_image)
  end

end
