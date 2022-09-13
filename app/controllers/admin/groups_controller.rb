class Admin::GroupsController < ApplicationController
  layout "admin_application"

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @group_users = @group.end_users.page(params[:page]).per(10)
    @memories = @group.group_memories.page(params[:page]).per(6)
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to admin_groups_path
  end

end
