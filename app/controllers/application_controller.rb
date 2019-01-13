require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  
  get '/' do
    if logged_in?
      redirect '/tweets'
    end
    erb :index
  end

  helpers do

    def current_user
      @user = User.find_by_id(session[:user_id])
    end
  
    def logged_in?
      !!session[:user_id]
    end
  end
end

