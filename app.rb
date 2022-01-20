# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/space'
require 'pg'
require_relative 'database_connection_setup'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    erb :index
  end

  get '/users/new' do
    session[:user_id] = params[:user_id]
    erb :'users/new'
  end

  post '/users' do
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

=begin
  get '/spaces/:id' do
    @space = Space.id

    erb :'/space_views/space' # too confusing?
  end

  post '/spaces/:id' do
    Booking.add(space_id: id, host_id: (from table rather than arg?), customer_id: session[user_id], start_date: params[start_date], end_date: params[end_date] status: (don't need here?))
    
    redirect '/spaces'
  end
=end
  
  run! if app_file == $PROGRAM_NAME
end
