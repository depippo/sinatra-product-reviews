class UserController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to "/reviews"
    else
      @failure_message = session[:failure_message]
      session[:failure_message] = nil
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      session[:failure_message] = "Please enter a username and a password."
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
      @failure_message = session[:failure_message]
      session[:failure_message] = nil
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/reviews"
    else
      session[:failure_message] = "Invalid username/password. Please try again."
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

  get '/users' do
    if Helpers.is_logged_in?(session)
      @users = User.all
      erb :'/users/index'
    else
      redirect to "/login"
    end
  end

  get '/users/:slug' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show_user'
    else
      redirect to "/login"
    end
  end

end