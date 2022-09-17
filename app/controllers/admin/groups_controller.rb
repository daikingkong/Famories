class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @group_users = @group.end_users.page(params[:page]).per(10).order("created_at DESC")
    @memories = @group.group_memories.page(params[:page]).per(12).order("created_at DESC")
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to admin_groups_path, notice: "グループを削除しました。"
  end

end
