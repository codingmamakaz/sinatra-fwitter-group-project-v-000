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
    if logged_in?
        redirect '/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    # if @user != nil && @user.authenticate(params[:password])
    if @user 
      session[:user_id] = @user.id
      redirect '/tweets'
    end
    redirect '/signup'
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/tweets/new' do
    if !logged_in?
        redirect '/login'
    end
    erb :'/tweets/new'
    # end
    # erb :'/login'
  end

  post '/tweets' do
    if params[:content] == ""
        redirect :'/tweets/new'
    end

    @tweet = Tweet.create(params)
    @user = User.find_by_id(session[:user_id])
    @tweet.user_id = @user.id
    @tweet.save
        
    redirect :'/tweets'
  end
 
  get '/logout' do
    if logged_in?
      session.clear
    end
  redirect '/login'
  end
  

end
