class Public::GroupUsersController < ApplicationController

  # リクエスト承認でグループに加入し、そのリクエストを削除
  def approve
    group = Group.find(params[:group_id])
    join_request = group.join_requests.find_by(group_id: group.id)
    request_user = join_request.end_user
    group.end_users << request_user
    join_request.destroy
    redirect_to group_path(group)
  end

  def refuse
    group = Group.find(params[:group_id])
    join_request = group.join_requests.find_by(group_id: group.id)
    join_request.destroy
    redirect_to request.referer
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
      redirect_to request.referer, notice: "オーナーはグループを削除することで退会できます。"
    end
  end

  def unsubscribe_confirm
    @group = Group.find(params[:group_id])
  end

end
