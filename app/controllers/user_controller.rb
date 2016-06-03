class UserController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to "/reviews"
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.new(params)
      @user.save
      session[:user_id] = @user.id
      redirect to "/reviews"
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to "/reviews"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/reviews"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to "/login"
    else
      redirect to "/"
    end
  end
end