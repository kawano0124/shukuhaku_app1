class ReservationsController < ApplicationController
  before_action :set_room, only: [:new, :create, :confirm]
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:room)
  end

  def new
    @reservation = @room.reservations.build
  end

  def create
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user

    if @reservation.valid?
      session[:reservation_data] = reservation_params # セッションに予約データを保存
      redirect_to confirm_room_reservations_path(@room) # 確認ページにリダイレクト
    else
      render 'rooms/show'
    end
  end

  def confirm
    if request.post?
      # POSTリクエストの場合は予約を確定する
      @reservation = @room.reservations.new(session[:reservation_data])
      @reservation.user = current_user

      if @reservation.save
        session.delete(:reservation_data) # セッションからデータを削除
        redirect_to reservations_path, notice: '予約が確定しました。'
      else
        render :confirm # バリデーションエラーがある場合は再表示
      end
    else
      # GETリクエストの場合は予約確認ページを表示する
      @reservation = @room.reservations.new(session[:reservation_data])
      @reservation.user = current_user
    end
  end


  def set_room
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :number_of_people, :room_id)
  end
end
