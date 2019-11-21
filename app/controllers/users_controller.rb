class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            flash[:message] = "You're already logged in and don't need to sign up!"
            redirect '/tweets'
        else
            erb :'/users/new'
        end
    end

    post '/signup' do
        
        if params[:username] == "" || params[:password] == "" || params[:email] == ""
            flash[:message] = "Please make sure each section is properly filled in"
            redirect '/signup'
        else
            @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to '/tweets'
        end
    end

    get '/login' do
        if logged_in?
            flash[:message] = "You are already logged in"
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            flash[:message] = "Couldn't find an account with that information! Sign up today!"
            redirect '/signup'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            flash[:message] = "You have logged out"
            redirect '/login'
        else
            redirect '/'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

end
