class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        if logged_in?
            @user = User.find_by_id(session[:user_id])
            erb :"/tweets/index"
        else
            flash[:message] = "Please Login or Sign Up first"
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :"/tweets/new"
        else
            flash[:message] = "Please Login or Sign Up first"
            redirect '/login'
        end
    end

    post '/tweets' do
        if logged_in?
            if params[:content] == ""
                flash[:message] = "Please Add Content To Your Message"
                redirect '/tweets/new'
            else
                @tweet = current_user.tweets.build(content: params[:content])
                if @tweet.save
                    redirect "/tweets/#{@tweet.id}"
                else
                    redirect '/tweets/new'
                end
            end
            redirect '/tweets'
        else
            flash[:message] = "Please Login or Sign Up first"
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = find_tweet
            erb :"/tweets/show"
        else
            flash[:message] = "Please Login or Sign Up first"
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = find_tweet
        if logged_in? && @tweet.user == current_user
            erb :"/tweets/edit"
        elsif logged_in? && @tweet.user != current_user
            flash[:message] = "Sorry, you can't edit tweets that aren't yours!"
            redirect "/tweets/#{@tweet.id}"
        else
            flash[:message] = "Please Login or Sign Up first"
            redirect "/login"
        end
    end

    patch '/tweets/:id' do
        if logged_in?
            @tweet = find_tweet
            if params[:content] == ""
                flash[:message] = "Please Add Content To Your Message"
                redirect "/tweets/#{@tweet.id}/edit"
            else
                @tweet.update(content: params[:content])
                @tweet.save
            end
        end
        redirect "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id/delete' do
        if logged_in?
            @tweet = find_tweet
            flash[:message] = "Please do not try to force delete from the URL!"
            redirect "/tweets/#{@tweet.id}"
        else
            flash[:message] = "Please Login or Sign Up first"
            redirect 'login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = find_tweet
            if @tweet && @tweet.user == current_user
                @tweet.delete
                redirect '/tweets'
            elsif @tweet && @tweet.user != current_user
                flash[:message] = "Sorry, you can't delete tweets that aren't yours!"
                redirect '/tweets'
            end
        else
            flash[:message] = "Please Login or Sign Up first"
            redirect '/login'
        end
    end

    helpers do

        def find_tweet
            Tweet.find_by_id(params[:id])
        end

    end

end
