class TweetsController < ApplicationController

    get '/tweets' do
        if !logged_in?
            redirect '/login'
        end
        @tweets = Tweet.all
        erb :'/tweets/tweets'
    end

    get '/tweets/new' do
        if !logged_in?
            redirect to '/login'
        end
        erb :'/tweets/new'
    end
    
    post '/tweets' do
        if params[:content] == ""
            redirect :'/tweets/new'
        end
        
        # @tweet = current_user.tweets.build(content: params[:content])
        # if @tweet.save
        #   redirect to "/tweets/#{@tweet.id}"
        # else 
        #   redirect to "/tweets/new"
        # end 
        # @tweet = Tweet.create(params)
        # if logged_in
            session[:user_id] == current_user[:id] 
            @tweet = Tweet.create(params)
            @tweet.user_id = @user.id
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        # end
        # binding.pry
        # @tweet = current_user.tweets.create(params)
        # @user = User.find_by_id(session[:user_id])
        # @tweet.save
            

        #
        # @tweet = Tweet.create(params)
        # @user = User.find_by_id(session[:user_id])
        # @tweet.user_id = @user.id
        # @tweet.save
        # redirect "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        end
        @tweet = Tweet.find_by_id(params[:id])
        @user = User.find_by_id(session[:user_id])
        erb :'/tweets/show_tweet'
    end

    get '/tweets/:id/edit' do
      if !logged_in?
          redirect '/login'
      end

      @tweet = Tweet.find_by_id(params[:id])
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/edit_tweet'
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if params[:tweet][:content].empty?
            redirect "/tweets/#{@tweet.id}/edit"
        end    
        @tweet.update(params[:tweet])
        redirect "/tweets/#{ @tweet.id }"
    end
      
    delete '/tweets/:id/delete' do
        @user = User.find_by_id(session[:user_id])
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == @user.id
          Tweet.destroy(params[:id])
          redirect :'/tweets'
        end
        redirect :'/login'
    end
     
end