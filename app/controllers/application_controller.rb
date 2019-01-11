require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  
  get '/' do
    erb :index
  end

  get '/signup' do
    if !!session[:user_id]
      binding.pry
      redirect 'tweets/tweets'
    end
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    end
    
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect 'tweets/tweets'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    # @user = User.find_by(username: params[:username], password: params[:password])
    @user = User.find_by(params)
    if @user
          session[:user_id] = @user.id
          redirect 'tweets/tweets'
    end
    binding.pry
    redirect '/signup'
  end
 

end

