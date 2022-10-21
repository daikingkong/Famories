class Public::MemoriesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_guest_user, only: [:new, :create, :edit, :update]
  before_action :ensure_correct_end_user, only: [:edit, :update, :destroy]

  layout "public_application"

  def new
    @memory = Memory.new
  end

  # メモリーとタグの紐づけ（送られてきたタグ名が新しければタグ新規作成も）を同時に行いたい
  # save_tagメソッドをMemoires.rbに記述しています。
  def create
    memory = current_end_user.memories.new(memory_params)
    tag_list = params[:memory][:name].split(/ |　/)
    tag_list = tag_list.uniq
    if memory.save
      if memory.save_tag(tag_list)
        redirect_to memory_path(memory), notice: "メモリーを作成しました。"
      end
    else
      redirect_to new_memory_path, alert: "メモリーの作成に失敗しました。"
    end
  end


  def index
    if params[:latest]
      @memories = Memory.latest.page(params[:page]).per(12)
    elsif params[:old]
      @memories = Memory.old.page(params[:page]).per(12)
    elsif params[:memory_favorite]
      @memories = Memory.memory_favorite.page(params[:page]).per(12)
    else
      @memories = Memory.page(params[:page]).per(12).order("created_at DESC")
    end
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

  # メモリーとタグの紐づけ（送られてきたタグ名が新しければタグ新規作成も）を同時に行いたい
  # save_tagメソッドをMemoires.rbに記述しています。
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
    memory = Memory.find(params[:id])
    unless memory.end_user_id == current_end_user.id
      redirect_to memory_path(memory), alert: '自分のメモリーの以外は編集できません'
    end
  end

  def memory_params
    params.require(:memory).permit(:title, :memo, :end_user_id, :memory_image)
  end

end
