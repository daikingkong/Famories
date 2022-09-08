class Public::EndUsersController < ApplicationController
  layout "public_application"

  def show
    @end_user = current_end_user
    @end_user_groups = @end_user.groups
    @end_user_memories = @end_user.memories.page(params[:page]).per(6)
  end

  def edit
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
