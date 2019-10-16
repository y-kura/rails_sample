class UsersController < ApplicationController
  protect_from_forgery

  def login
    if params[:name]
      user = User.find_by(name: params[:name])
      if user && user.password == params[:password]
        session[:user_id] = user.id
        session[:name] = user.name
        redirect_to controller: 'test', action: 'index'
      else
        @error = 'ログインIDまたはパスワードが違います'
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:name] = nil
    redirect_to controller: 'test', action: 'index'
  end

  def create
    logger.debug '----'
    logger.debug params[:name]
    logger.debug '----'
    if params[:name] == ''
      logger.debug '======'
    end


    logger.debug 'XXXXXX'

  end

  def new
    if params[:name]
      if params[:name] == ''
        @error = 'ログインIDを入力してください'
      elsif params[:password] == ''
        @error = 'パスワードを入力してください'
      elsif params[:password] != params[:password_confirm]
        @error = '確認のパスワードが異なります'
      else
        user = User.new(name: params[:name], password: params[:password])
        if user.save
          redirect_to controller: 'test', action: 'index'
        end
      end
      end
  end
end
