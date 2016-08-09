require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :"/diver/home"
  end

  get "/signup" do
    erb :"/diver/signup"
  end

  post "/signup" do
    @diver = Diver.create(params[:diver])
    session[:id] = @diver.id
    redirect "/add_times"
  end

  get "/login" do
    erb :"/diver/login"
  end

  get "/add_times" do
    erb :"/times/add_times_home"
  end

  post "/add_times/static" do
    @static = Static.create(params[:static])
  end

  post "/add_times/dynamic" do
    @dynamic = Dynamic.create(params[:dynamic])
  end



end
