# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space'
require './lib/booking'
require 'pg'
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

  post '/users/new' do
    session[:user_id] = params[:user_id]
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
    Space.add(name: params[:name], description: params[:description], price: params[:price], available_from: params[:available_from], available_to: params[:available_to], user_id: session[:user_id])
    redirect '/spaces'
  end

  get '/spaces/:id' do
    @space = Space.specific_space(params[:id])
    erb :'/space_views/space_page'
  end

  get '/bookings' do 
    p 'sessions...', session[:user_id]
    # @bookings = Booking.all_booking_received(host_id: session[:user_id])
    erb :'bookings/index'
  end 
  
  run! if app_file == $PROGRAM_NAME
end
