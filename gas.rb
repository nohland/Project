#this is our app file

require 'rubygems'
require 'bundler/setup'
Bundler.require
require './models/User'
require './models/Car'

if ENV['DATABASE_URL']
   ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
   ActiveRecord::Base.establish_connection(
        :adapter  => 'sqlite3',
        :database => 'db/development.db',
        :encoding => 'utf8'
)
end

get '/' do
    @users = User.all.order(:name)
    erb :welcome
end

get '/:user' do
   @user = User.find(params[:user])
   @cars = @user.cars.order(:car_description)
   erb :user_page
end

post '/new_user' do
     @user = User.create(params)
     redirect '/'
end

post '/delete_user/:id' do
    User.find(params[:id]).destroy
    redirect '/'
end

post '/:user/new_car' do
     User.find(params[:user]).cars.create(car_description: params[:car])
     redirect "/#{params[:user]}"
end

get '/delete_car/:car' do 
       @car_description = Car.find(params[:car])
       @user = @car_description.user
       @car_description.destroy   
       redirect "/#{@user.id}"
end



helpers do

  def blank?(x)
    x.nil? || x == ""
  end
end



