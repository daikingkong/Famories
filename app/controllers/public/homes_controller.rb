class Public::HomesController < ApplicationController

  layout "public_application"

  def top
    @memories = Memory.all.order("created_at DESC").first(3)
  end

  def about
  end
end
