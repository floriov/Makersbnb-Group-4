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

  get '/spaces/:id' do
    @space = Space.specific_space(id)
    
    erb :'/space_views/space_page'
  end
  
  run! if app_file == $PROGRAM_NAME
end
