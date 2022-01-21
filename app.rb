# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/user'
require './lib/space'
require './lib/booking'
require 'pg'
require 'bcrypt'
require_relative 'database_connection_setup'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/booking.rb'
    also_reload 'lib/user.rb'
    also_reload 'lib/space.rb'
  end

  enable :sessions

  get '/' do
    erb :index
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = params[:username]
    password = params[:password]
    if User.match?(user, password)
      session[:user_id] = User.find_id(user)
      redirect '/spaces'
    else
      redirect '/'
    end
  end

  post '/users/new' do
    user = User.add(username: params[:username],
      email: params[:email], 
      password: params[:password])
    session[:user_id] = user.id

    redirect '/spaces'
  end

  get '/spaces' do
    @spaces = Space.all

    erb :'/space_views/spaces'
  end

  get '/spaces/add' do
    erb :'/space_views/add'
  end

  post '/spaces/add' do
    Space.add(name: params[:name], 
      description: params[:description], 
      price: params[:price], 
      available_from: params[:available_from], 
      available_to: params[:available_to], 
      user_id: session[:user_id])

    redirect '/spaces'
  end

  get '/spaces/:id' do
    @space = Space.specific_space(params[:id])
    
    erb :'/space_views/space_page'
  end

  post '/spaces/:id/request-confirmation' do
    Booking.add(space_id: params[:id],
      customer_id: session[:user_id],
      start_date: params[:start_date], 
      end_date: params[:end_date], 
      status: 'requested')
    
    redirect '/spaces/:id/request-confirmation'
  end

  get '/spaces/:id/request-confirmation' do
    erb :'/space_views/request_confirmation'
  end

  get '/bookings' do 
    @bookings = Booking.all_booking_received(host_id: session[:user_id])
    #need this method to cross reference the spaces_id 
    #from the booking sheet WITH the spaces table 
    #would this sit within the bookings class?
    #i.e. based upon the space_id provided in the booking, what is the spaces details?
    @spaces = Space.specific_space(2)
    erb :'bookings/index'
  end
  
  run! if app_file == $PROGRAM_NAME
end
