class Public::JoinRequestsController < ApplicationController
  layout "public_application"

  def index
    @group = Group.find(params[:group_id])
    @group_users = @group.end_users
    @join_requests = @group.join_requests.page(params[:page]).per(10)
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

end
