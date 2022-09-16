class Public::MemoryTagsController < ApplicationController
  before_action :authenticate_end_user!

  layout "public_application"

  def index
    @memory_tags = MemoryTag.page(params[:page]).per(50)
  end

end
