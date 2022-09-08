class Public::EndUsersController < ApplicationController
  layout "public_application"

  def show
    @end_user = current_end_user
    @end_user_groups = @end_user.groups
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
