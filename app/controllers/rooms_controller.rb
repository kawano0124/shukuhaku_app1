class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def index
    @rooms = Room.all
  end
  
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_path, notice: "施設が作成されました"
    else
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(params.require(:room).permit(:room_name, :room_introduction, :room_price, :room_address, :image))
       flash[:notice] = "施設情報を更新しました"
       redirect_to :users
      else
       render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設を削除しました"
    redirect_to :rooms
  end

  def room_params
    params.require(:room).permit(:room_name, :room_introduction, :room_price, :room_address, :image)
  end

end
