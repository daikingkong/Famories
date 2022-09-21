class Public::MemoriesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_guest_user, only: [:new, :create, :edit, :update]
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]

  layout "public_application"

  def new
    @memory = Memory.new
  end


  # メモリー投稿とタグ付け（なければ作成）を同時に行う
  def create
    memory = current_end_user.memories.new(memory_params)
    tag_list = params[:memory][:name].split(/ |　/)
    tag_list = tag_list.uniq
    if memory.save
      if memory.save_tag(tag_list)
        @end_user = memory.end_user
        redirect_to memory_path(memory), notice: "メモリーを作成しました。"
      end
    else
      redirect_to new_memory_path, alert: "メモリーの作成に失敗しました。"
    end
  end


  def index
    @memories = Memory.page(params[:page]).per(12).order("created_at DESC")
    @end_user = current_end_user
    @user_groups = @end_user.groups.order("created_at DESC")
  end

  def show
    @memory = Memory.find(params[:id])
    @memory_tags = @memory.memory_tags
    @memory_comments = @memory.memory_comments.page(params[:page]).per(10).order("created_at DESC")
    @memory_comment = MemoryComment.new
  end

  def edit
    @memory = Memory.find(params[:id])
    @memory_tags = @memory.memory_tags
  end

  # メモリー更新とタグ付け更新を同時に行う
  def update
    memory = Memory.find(params[:id])
    tag_list = params[:memory][:name].split(/ |　/)
    tag_list = tag_list.uniq
    if memory.update(memory_params)
      if memory.save_tag(tag_list)
        redirect_to memory_path(memory), notice: "メモリーを編集しました。"
      end
    else
      redirect_to edit_memory_path(memory), alert: "メモリーの編集に失敗しました。"
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
    @memory_tag = MemoryTag.find(params[:memory_tag_id])
    @memories = @memory_tag.memories.page(params[:page]).per(12).order("created_at DESC")
  end

  private

  def ensure_correct_end_user
    @memory = Memory.find(params[:id])
    unless @memory.end_user_id == current_end_user.id
      redirect_to memory_path(@memory), alert: '自分以外のメモリーの編集はできません'
    end
  end

  def memory_params
    params.require(:memory).permit(:title, :memo, :end_user_id, :memory_image)
  end

end
