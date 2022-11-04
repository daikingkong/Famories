class Admin::MemoryTagsController < ApplicationController
  before_action :authenticate_admin!

  layout "admin_application"

  def index
    @memory_tags = MemoryTag.all
  end

  def destroy
    @memory_tags = MemoryTag.all
    memory_tag = MemoryTag.find(params[:id])
    memory_tag.destroy
  end
end
