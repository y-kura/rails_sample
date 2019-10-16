class MainController < ApplicationController
  def index
  	@titletag = 'mini board'
    @board = Board.first
    if @board
      @titletag = @board[:title] + ' - mini board'
      if cookies[:login]
      	#
      	# 掲示板
      	#

        # メッセージ取得
        @messages = Message.all.order(:created_at => :desc).limit(5)

        # 名前に初期値を設定
        @message = Message.new
        if cookies[:name]
          @message[:name] = cookies[:name]
        end

        if request.post?
          # 掲示板への書き込み
          @message = Message.new(params.require(:message).permit(:name, :body))
          if @message.save
          	cookies[:name] = params[:message][:name]
            redirect_to :action => :index
          else
            render :message
          end
        else
          # 掲示板画面の表示
	      render :message
        end
      else
        #
        # 掲示板へのログイン
        #
        if request.post?
          # ログイン
          password = params[:board][:password]
          if @board[:password] == password
            # ログイン成功
            cookies[:login] = true
            redirect_to :action => :index
          else
            # ログイン失敗
            @msg = 'パスワードが間違っています'
            @auth_board = Board.new
	        render :login
          end
        else
          # ログイン画面の表示
          @auth_board = Board.new
          render :login
        end
      end
    else
      #
      # 掲示板の初期設定
      #
      if request.post?
        # 初期設定
        @board = Board.new(params.require(:board).permit(:title, :password))
        if @board.save
          cookies[:login] = false
          redirect_to :action => :index
        else
          render :init
        end
      else
        # 初期設定画面の表示
        @board = Board.new
        render :init
      end
    end
  end
end
