class Public::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  layout 'public_application'


  # キーワード検索の対象となるモデルを判定
  def search
    @model = params[:model]
    @content = params[:content]
    if @model == 'memory'
      @records = Memory.search_for(@content).page(params[:page]).per(6)
    elsif @model == 'group'
      @records = Group.search_for(@content).page(params[:page]).per(10)
    end
    @end_user = current_end_user
    @user_groups = @end_user.groups.page(params[:page]).per(10)
  end

end