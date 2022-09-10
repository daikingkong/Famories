class Public::GroupsController < ApplicationController
  layout "public_application"

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_end_user.id
    @group.end_users << current_end_user
    @group.save
    redirect_to group_path(@group)
  end

  def index
    @groups = Group.page(params[:page]).per(10)
    @end_user = current_end_user
    @user_groups = @end_user.groups.page(params[:page]).per(10)
  end

  def show
    @group = Group.find(params[:id])
    @group_users = @group.end_users
    @memories = @group.group_memories.page(params[:page]).per(6)
  end

  def edit
  end

  def update
  end

  def destroy
    @group = Group.find(params[:id])
    unless current_end_user.id == @group.owner_id
      @group.end_users.destroy(current_end_user)
      redirect_to end_user_path(current_end_user)
    else
      redirect_to request.referer, notice: "オーナーはグループを削除することで退会できます。"
    end
  end

  def unsubscribe_confirm
    @group = Group.find(params[:group_id])
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id, :group_image)
  end

end
