require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    erb :'index'
  end

  get '/users/new' do
    erb :'users/new'
  end 

  post '/users' do
    redirect '/'
  end 

  run! if app_file == $0
end
