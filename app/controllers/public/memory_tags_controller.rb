class Public::MemoryTagsController < ApplicationController
  layout "public_application"

  def index
    @memory_tags = MemoryTag.page(params[:page]).per(50)
  end

end
