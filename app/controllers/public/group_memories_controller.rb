class Public::GroupMemoriesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_guest_user
  before_action :ensure_correct_memory_user, only: [:edit, :update, :destroy]
  before_action :ensure_correct_group_user

  layout "public_application"

  def new
    @memory = GroupMemory.new
    @group = Group.find(params[:group_id])
  end

  # グループ内でのメモリー投稿はグループと会員の情報を持たせる必要がある
  def create
    @group = Group.find(params[:group_id])
    memory = @group.group_memories.new(group_memory_params)
    memory.end_user_id = current_end_user.id
    if memory.save
      redirect_to group_group_memory_path(@group, memory), notice: "メモリーを作成しました。"
    else
      redirect_to new_group_group_memory_path(@group), notice: "メモリーの作成に失敗しました。"
    end
  end

  def show
    @group = Group.find(params[:group_id])
    @memory = GroupMemory.find(params[:id])
  end

  def edit
    @group = Group.find(params[:group_id])
    @memory = GroupMemory.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    memory = GroupMemory.find(params[:id])
    if memory.update(group_memory_params)
      redirect_to group_group_memory_path(@group, memory), notice: "メモリーを更新しました。"
    else
      redirect_to edit_group_group_memory_path(@group, memory), notice: "メモリーの更新に失敗しました。"
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    memory = GroupMemory.find(params[:id])
    memory.destroy
    redirect_to group_path(@group), notice: "メモリーを削除しました。"
  end

  private

  # オーナーとグループで投稿したメモリーのユーザ以外のアクション制限
  def ensure_correct_memory_user
    @group = Group.find(params[:group_id])
    @group_memory = GroupMemory.find(params[:id])
    if @group.owner_id == current_end_user.id
    else
      unless @group_memory.end_user_id == current_end_user.id
        redirect_to end_user_path(current_end_user), notice: "グループのメンバーのみ利用可能です。"
      end
    end
  end

  def ensure_correct_group_user
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.where(group_id: @group, end_user_id: current_end_user.id)
    if @group_user.present?
    else
      redirect_to end_user_path(current_end_user), notice: "グループのメンバーのみ利用可能です。"
    end
  end

  def group_memory_params
    params.require(:group_memory).permit(:title, :memo, :group_id, :end_user_id, :memory_image)
  end

end