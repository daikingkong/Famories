class Public::GroupMemoriesController < ApplicationController
  layout "public_application"

  def new
    @memory = GroupMemory.new
    @group = Group.find(params[:group_id])
  end

  def create
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
