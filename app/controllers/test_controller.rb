require "base64"

class TestController < ApplicationController
  protect_from_forgery :except => [:add]

  before_action :require_login

  def top
  end

  def index
    @blogs = Blog.all
    #@debug = Blog.all.inspect
  end

  def show
    @blog = Blog.find(params[:id])
    @user = User.find_by(id: @blog.user_id)

  end

  def image
    @blog = Blog.find(params[:id])
    send_data(Base64.decode64(@blog[:body]), :type => 'image/jpeg', :disposition => 'inline')
  end

  def add
    if request.post?
      if params[:title] == ''
        params[:title] = '(no title)'
      end

      image = Base64.strict_encode64(params[:image].read)
      blog = Blog.new(title: params[:title], body: image, user_id: session[:user_id])
      if blog.save
        #redirect_to :action => :index
        render :json => [status: "ok"]
      end
    end
  end

  def edit
    @blog = Blog.find(params[:id])
    if request.post?
      @blog[:title] = params[:title]
      @blog[:body] = params[:body]
      if @blog.save
        #redirect_to :action => :index
        redirect_to controller: 'test', action: 'index'
      end
    end
  end

  def delete
    if request.delete?
      Blog.find(params[:id]).destroy
    end
    #redirect_to :action => :index
    redirect_to controller: 'test', action: 'index'
  end

  def test
    #@debug = User.count
    #logger.debug '----'
    #logger.debug User.count
    #logger.debug User.all.inspect
    #logger.debug '----'
  end


  private

  def require_login
    #logger.debug '============='
    #@debug = session[:user_id]
    #logger.debug '============='
  end

end
