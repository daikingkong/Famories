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

  def updata
  end

  def destroy
  end

  def unsubscribe
  end

  def thanks
  end

  def favorite_memories
  end

end
