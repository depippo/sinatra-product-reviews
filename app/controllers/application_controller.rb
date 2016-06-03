require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "Kiwi"
  end

  get '/' do
   if Helpers.is_logged_in?(session)
    redirect to "/reviews"
    else
      erb :'/index'
    end
  end

end