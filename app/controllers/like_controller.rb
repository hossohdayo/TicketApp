class LikeController < ApplicationController
  def index
    @like = Like.joins(:ticket, :user).select('tickets.*, likes.*, users.name').where(user_id: @usr.id)
  end

  def create
    @like = Like.create(like_params)
    redirect_back fallback_location: {controller: 'ticket', action: 'index'}
  end

  def destroy
    @like = Like.find_by(like_params)
    @like.destroy
    redirect_back fallback_location: {controller: 'ticket', action: 'index'}
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :ticket_id)
  end
end
