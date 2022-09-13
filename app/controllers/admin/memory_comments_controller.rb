class Admin::MemoryCommentsController < ApplicationController
  layout "admin_application"

  def index
    @memory_comments = MemoryComment.page(params[:page]).per(10)
  end

  def destroy
  end

end
