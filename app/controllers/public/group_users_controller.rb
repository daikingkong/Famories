class Public::GroupUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_guest_user
  before_action :ensure_correct_group_user

  layout "public_application"

# 加入リクエストの承認でグループに加入し、さらに不要になったその加入リクエストを削除するため
  def approve
    @group = Group.find(params[:group_id])
    join_request = @group.join_requests.find_by(group_id: @group)
    request_user = join_request.end_user
    @group.end_users << request_user
    join_request.destroy
    @join_requests = @group.join_requests.page(params[:page]).per(12)
    @group_users = @group.end_users
  end


# 加入リクエストの承認でグループに加入し、さらに不要になったその加入リクエストを削除するため
  def refuse
    @group = Group.find(params[:group_id])
    join_request = @group.join_requests.find_by(group_id: @group.id)
    join_request.destroy
    @join_requests = @group.join_requests.page(params[:page]).per(12)
    @group_users = @group.end_users
  end


# オーナーは自身以外のグループユーザーを削除できる。
# メンバー自身が退会すると、マイページに遷移する。
  def destroy
    group = Group.find(params[:group_id])
    end_user = EndUser.find(params[:id])
    group_user = GroupUser.find_by(group_id: group.id, end_user_id: end_user.id)
    unless end_user.id == group.owner_id
      group_user.destroy
      if group.owner_id == current_end_user.id
        redirect_to request.referer, notice: "メンバーを退会させました。"
      else
        redirect_to end_user_path(end_user), notice: "グループを退会しました。"
      end
    else
      redirect_to request.referer, alert: "現在、オーナーが退会することはできません"
    end
  end


  def unsubscribe_confirm
    @group = Group.find(params[:group_id])
  end


  private


  def ensure_correct_group_user
    group = Group.find(params[:group_id])
    group_user = GroupUser.where(group_id: group, end_user_id: current_end_user.id)
    if group_user.present?
    else
      redirect_to end_user_path(current_end_user), alert: "グループのメンバーのみ利用可能です。"
    end
  end

end