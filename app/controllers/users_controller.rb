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

  get '/tweets/:id' do
    if !logged_in?
        redirect '/login'
    end

    @tweet = Tweet.find_by_id(params[:id])
    @content = @tweet.content
    erb :'/tweets/show_tweet'
  end
 
  get '/tweets/:id/edit' do
    if !logged_in?
        redirect '/login'
    end

    @tweet = Tweet.find_by_id(params[:id])
    @content = @tweet.content
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:tweet][:content].empty?
        redirect "/tweets/#{@tweet.id}/edit"
    end    
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(params[:tweet])
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
  redirect '/login'
  end
  
end
