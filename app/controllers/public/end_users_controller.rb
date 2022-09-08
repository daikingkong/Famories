class Public::EndUsersController < ApplicationController
  layout "public_application"

  def show
    @end_user = EndUser.find(params[:id])
    @end_user_groups = @end_user.groups
    @end_user_memories = @end_user.memories.page(params[:page]).per(6)
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

  def unsubscribe
    @end_user = EndUser.find(params[:end_user_id])

  end

  def thanks
  end

  def favorite_memories
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :email, :profile_image)
  end

end
