class Public::MemoriesController < ApplicationController
  before_action :ensure_guest_user, only: [:new, :create, :edit, :update]

  layout "public_application"

  # ゲストユーザーは閲覧のみできる
  def new
    @memory = Memory.new
  end

  # メモリー投稿とタグ作成をする機能
  def create
    memory = current_end_user.memories.new(memory_params)
    tag_list = params[:memory][:name].split("　")
    if memory.save
      if memory.save_tag(tag_list)
        @end_user = memory.end_user
        redirect_to memory_path(memory), notice: "メモリーを作成しました。"
      end
    else
      redirect_to new_memory_path, notice: "メモリーの作成に失敗しました。"
    end
  end

  def index
    @memories = Memory.page(params[:page]).per(6)
    @end_user = current_end_user
    @user_groups = @end_user.groups
  end

  def show
    @memory = Memory.find(params[:id])
    @memory_tags = @memory.memory_tags.page(params[:page]).per(5)
    @memory_comments = @memory.memory_comments.page(params[:page]).per(8)
    @memory_comment = MemoryComment.new
  end

  def edit
    @memory = Memory.find(params[:id])
    @memory_tags = @memory.memory_tags.page(params[:page]).per(5)
  end

  def update
    memory = Memory.find(params[:id])
    tag_list = params[:memory][:name].split("　")
    if memory.update(memory_params)
      if memory.save_tag(tag_list)
        redirect_to memory_path(memory), notice: "メモリーを編集しました。"
      end
    else
      redirect_to edit_memory_path(memory), notice: "メモリーの編集に失敗しました。"
    end
  end

  def destroy
    memory = Memory.find(params[:id])
    memory.destroy
    redirect_to end_user_path(current_end_user), notice: "メモリーを削除しました。"
  end

  def tag_search
    @end_user = current_end_user
    @user_groups = @end_user.groups
    @memory_tags = MemoryTag.page(params[:page]).per(5)
    @memory_tag = MemoryTag.find(params[:memory_tag_id])
    @memories = @memory_tag.memories.page(params[:page]).per(6)
  end

  private

  def memory_params
    params.require(:memory).permit(:title, :memo, :end_user_id, :memory_image)
  end

end
