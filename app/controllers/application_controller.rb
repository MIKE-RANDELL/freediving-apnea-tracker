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
      flash[:message] = "Message: Please fill out a name + password"
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
      flash[:message] = "Message: Wrong name/password combination. Please try again or signup!"
    end
  end

  get "/add_times" do
    @diver = Diver.find(session[:id])
    erb :"/times/add_times_home"
  end

  post "/add_times/static" do
    if !params[:static][:max_time].blank? || !params[:static][:overall_state].blank?
      @static = Static.create(params[:static])
      @diver = Diver.find(session[:id])
      @diver.statics << @static
      @diver.save
      redirect "/add_times"
    else
      flash[:message] = "Message: Please fill in both static time and state, both are important."
      redirect "/add_times"
    end
  end

  post "/add_times/dynamic" do
    if !params[:dynamic][:distance].blank? || !params[:dynamic][:overall_state].blank?
      @dynamic = Dynamic.create(params[:dynamic])
      @diver = Diver.find(session[:id])
      @diver.dynamics << @dynamic
      @diver.save
      redirect "/add_times"
    else
      flash[:message] = "Message: Please fill in both dynamic distance and state, both are important."
      redirect "/add_times"
    end
  end

  get "/log/:id" do
    @diver = Diver.find(params[:id])
    erb :"/diver/log"
  end

  get "/experience/:id/edit" do
    @diver = Diver.find(params[:id])
    erb :"/diver/edit_experience"
  end

  patch "/experience/:id/edit" do
    @diver = Diver.find(session[:id])

    if @diver.id.to_s == params[:id]
      @diver.experience = params[:diver][:experience]
      @diver.save
      redirect "/log/#{session[:id]}"
    else
      flash[:message] = "<b>Message:</b> You can only update your own experience."
      redirect "/log/#{session[:id]}"
    end
  end
  
  get "/logout" do
    session.clear
    redirect "/login"
  end
end
