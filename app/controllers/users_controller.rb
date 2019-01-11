class UsersController < ApplicationController

  get '/signup' do
    if !!session[:user_id]
      redirect '/tweets'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    end
    
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    # if @user != nil && @user.authenticate(params[:password])
    if @user 
      session[:user_id] = @user.id
      binding.pry
      redirect '/tweets'
    end
    redirect '/signup'
  end
 

end
