class Public::JoinRequestsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_guest_user
  before_action :ensure_correct_group_owner, only: [:index]

  layout "public_application"

  def index
    @group = Group.find(params[:group_id])
    @group_users = @group.end_users
    @join_requests = @group.join_requests.page(params[:page]).per(10).order("created_at DESC")
  end

  def create
    group = Group.find(params[:group_id])
    join_request = current_end_user.join_requests.new(group_id: group.id)
    join_request.save
    redirect_to request.referer
  end

  def destroy
    group = Group.find(params[:group_id])
    join_request = current_end_user.join_requests.find_by(group_id: group.id)
    join_request.destroy
    redirect_to request.referer
  end

  private

  def ensure_correct_group_owner
    @group = Group.find(params[:group_id])
    unless @group.owner_id == current_end_user.id
      redirect_to group_path(@group), alert: 'オーナーのみ利用可能です'
    end
  end

end
