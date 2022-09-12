class Public::GroupMemoriesController < ApplicationController
  layout "public_application"

  def new
    @memory = GroupMemory.new
    @group = Group.find(params[:group_id])
  end

  # グループ内でのメモリー投稿はグループと会員の情報を持たせる必要がある
  def create
    @group = Group.find(params[:group_id])
    memory = GroupMemory.new(group_memory_params)
    memory.group_id = @group.id
    memory.end_user_id = current_end_user.id
    if memory.save
      redirect_to group_path(@group), notice: "メモリーを作成しました。"
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
  end

  def destroy
  end

  def group_memory_params
    params.require(:group_memory).permit(:title, :memo, :group_id, :end_user_id, :memory_image)
  end

end
