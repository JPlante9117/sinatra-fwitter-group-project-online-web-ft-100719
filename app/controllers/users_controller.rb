class UsersController < ApplicationController

    get '/signup' do
        #some stuff
        erb :'/users/new'
    end

    post '/signup' do
        user = User.new(username: params[:username], password: params[:password])
        if user.save
            redirect '/login'
        else
            redirect '/signup'
        end
    end

    get '/login' do
        #some stuff
        erb :'/users/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/'
        else
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/user/show'
    end

end
