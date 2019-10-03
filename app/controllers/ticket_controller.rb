class TicketController < ApplicationController
  include TicketHelper
  skip_before_action :check_logined, only: [:index]
  before_action :ensure_correct_ticket, only: [:edit]

  def index
    @ticket = Ticket.joins(:user).order(sort_column + ' ' + sort_direction).select('tickets.*, users.name')
    if session[:usr] != nil
      @usr = User.find(session[:usr])
    end
  end

  def show
    @ticket = Ticket.joins(:user).select('tickets.*, users.name').find_by(id: params[:id])
    @like = Like.new
  end

  def new
    @ticket = Ticket.new
  end

  def edit
    @msg = params[:id]
    @ticket = Ticket.find_by(id: params[:id])
  end

  def update
    @ticket = Ticket.find_by(id: params[:id])
    if @ticket.update(ticket_params)
      flash[:msg] = "チケットを編集しました"
      redirect_to '/ticket/index'
    else
      render 'ticket/edit'
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      flash[:msg] = "チケットを登録しました"
      redirect_to '/ticket/index'
    else
      render '/ticket/new'
    end
  end

  def destroy
    obj = Ticket.find_by(id: params[:id])
    obj.destroy
    flash[:msg] = "チケットを削除しました"
    redirect_to '/ticket/index'
  end

  def ensure_correct_ticket
    @ticket = Ticket.find_by(id: params[:id])
    if @ticket.user_id != @usr.id
      redirect_to '/ticket/index'
    end
  end

  private
  def ticket_params
    params.require(:ticket).permit(:game_date, :opponent, :comment, :price, :place, :user_id)
  end
end
