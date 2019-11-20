class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        erb :"/tweets/index"
    end

    get '/tweets/new' do
        erb :"/tweets/new"
    end

    post '/tweets' do
        #some other stuff
        redirect '/tweets'
    end

    get '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        erb :"/tweets/show"
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        #some other stuff
        erb :"/tweets/edit"
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        #some other stuff
        redirect "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.destroy
        
        redirect '/tweets'
    end

end
