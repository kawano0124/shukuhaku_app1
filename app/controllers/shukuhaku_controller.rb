class ShukuhakuController < ApplicationController
  def yoyaku
    @q = Room.ransack(params[:q])
    @rooms = @q.result
  end
end
