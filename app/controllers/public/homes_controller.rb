class Public::HomesController < ApplicationController

  layout "public_application"

  def top
    @memories = Memory.all.first(3)
  end

  def about
  end
end
