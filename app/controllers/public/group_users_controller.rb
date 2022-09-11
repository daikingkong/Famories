class Public::GroupUsersController < ApplicationController

  # リクエスト承認でグループに加入し、そのリクエストを削除
  def create
    group = Group.find(params[:group_id])
    join_request = group.join_requests.find_by(group_id: group.id)
    request_user = join_request.end_user
    group.end_users << request_user
    join_request.destroy
    redirect_to group_path(group)
  end

  def destroy
    group = Group.find(params[:group_id])
    join_request = group.join_requests.find_by(group_id: group.id)
    join_request.destroy
    redirect_to request.referer
  end

end
