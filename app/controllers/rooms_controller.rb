class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:search, :index, :show] 

  def new
    @room = Room.new
  end

  def search
    @q = Room.ransack(params[:q])
    @results = @q.result
    @total_count = @results.count
  end

  def index
    @q = Room.ransack(params[:q])  
    @rooms = @q.result
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to rooms_path, notice: "施設が作成されました"
    else
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = @room.reservations.build
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "施設情報を更新しました"
      redirect_to room_path(@room)
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設を削除しました"
    redirect_to rooms_path
  end

  def room_params
    params.require(:room).permit(:room_name, :room_introduction, :room_price, :room_address, :image)
  end
end
