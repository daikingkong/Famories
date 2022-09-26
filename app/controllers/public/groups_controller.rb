class Public::GroupsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_guest_user, except: [:index]
  before_action :ensure_correct_group_user, except: [:new, :create, :index]
  before_action :ensure_correct_group_owner, only: [:edit, :update]

  layout "public_application"

  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    group.owner_id = current_end_user.id
    group.end_users << current_end_user
    if group.save
      redirect_to group_path(group), notice: "グループの作成に成功しました。"
    else
      redirect_to new_group_path, alert: "グループの作成に失敗しました。"
    end
  end

  def index
    @groups = Group.page(params[:page]).per(12).order("created_at DESC")
    @end_user = current_end_user
    @user_groups = @end_user.groups.order("created_at DESC")
  end

  def show
    @group = Group.find(params[:id])
    @group_users = @group.end_users
    @memories = @group.group_memories.page(params[:page]).per(12).order("created_at DESC")
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    group = Group.find(params[:id])
    if group.update(group_params)
      redirect_to group_path(group), notice: "グループの編集に成功しました。"
    else
      redirect_to edit_group_path(group), alert: "グループの編集に失敗しました。"
    end
  end

  private

  def ensure_correct_group_owner
    group = Group.find(params[:id])
    unless group.owner_id == current_end_user.id
      redirect_to group_path(group), alert: "オーナーのみ利用可能です。"
    end
  end

  def ensure_correct_group_user
    group = Group.find(params[:id])
    group_user = GroupUser.where(group_id: group, end_user_id: current_end_user.id)
    if group_user.present?
    else
      redirect_to end_user_path(current_end_user), alert: "グループのメンバーのみ利用可能です。"
    end
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id, :group_image)
  end

end
