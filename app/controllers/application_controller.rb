require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash
  end

  get "/" do
    erb :"/diver/home"
  end

  get "/signup" do
    erb :"/diver/signup"
  end

  post "/signup" do
    @diver = Diver.new(params[:diver])
    if @diver.save
      session[:id] = @diver.id
      redirect "/add_times"
    else
      flash[:message] = "Please fill out a name + password"
      redirect "/signup"
    end
  end

  get "/login" do
    erb :"/diver/login"
  end

  post "/login" do
    @diver = Diver.find_by(:name => params[:diver][:name])

    if @diver && @diver.authenticate(params[:diver][:password])
      session[:id] = @diver.id
      redirect "/add_times"
    else
      redirect "/login"
      flash[:message] = "Wrong name/password combination. Please try again or signup!"
    end
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

  get "/logout" do
    session.clear
  end



end
