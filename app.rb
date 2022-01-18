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
    erb :'index'
  end
  
  get '/users/new' do
    session[:user_id] = params[:user_id]
    erb :'users/new'
  end 

  post '/users' do
    redirect '/'
  end 
  
  get '/spaces' do
    @spaces = Space.all

    erb :'/space_views/spaces' 
  end

  get '/spaces/add' do
    erb :'/space_views/add'
  end

  post '/spaces/add' do
    Space.add(name: params[:name], description: params[:description], price: params[:price], user_id: session[:user_id])
    p params
    
    redirect '/spaces'
  end

  run! if app_file == $0
end
