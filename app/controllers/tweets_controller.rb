class TweetsController < ApplicationController

    get '/tweets' do
        if !logged_in?
            redirect '/login'
        end
        erb :'/tweets/tweets'
    end
end