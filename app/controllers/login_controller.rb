class LoginController < ApplicationController
  skip_before_action :check_logined

  def auth
    usr = User.find_by(name: params[:name])
    if usr && usr.authenticate(params[:password]) then
      reset_session
      session[:usr] = usr.id
      redirect_to '/ticket/index'
    else
      flash.now[:referer] = params[:referer]
      @error = 'ユーザ名／パスワードが間違っています。'
      render 'index'
    end
  end

  def logout
    reset_session
    redirect_to '/login/index'
  end
end
