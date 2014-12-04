#this is our app file

require 'rubygems'
require 'bundler/setup'
Bundler.require
require './models/User'
require './models/Car'
require './models/Calc'

enable :sessions
set :session_secret, '85txrIIvTDe0AWPCvbeXuXXpULCWZgpoRo1LqY8YsR9GAbph0jfOHosvtY4QFxi6'
if ENV['DATABASE_URL']
   ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
   ActiveRecord::Base.establish_connection(
        :adapter  => 'sqlite3',
        :database => 'db/development.db',
        :encoding => 'utf8'
)
end

before do
       @user = User.find_by(name: session[:name])
end



get '/' do
    if @user
       @cars = @user.cars.order(:car_description)
       #@car = Car.find(params[:car])
       
       #User.find(params[:user]).cars.create(avg_fill_price: avg_price)
       erb :user_page
    else 
       erb :welcome	
    end
end

post '/login' do
     user = User.find_by(name: params[:name])
     if user.nil?
     	@message = "User not found"
     	erb :message_page
     elsif user.authenticate(params[:password])
     	   session[:name] = user.name
	   redirect '/'
     else
	   @message = "Incorrect password"
	   erb :message_page
     end
end	
	   

get '/logout' do
    session.clear
    redirect '/'
end

get '/show_car/:car/:user' do
    @car = Car.find(params[:car])
    @user = User.find(params[:user])
    @description = @car.calcs.order(:date)
    #@avg = @user.cars.find(:mil_avg)
    #@avg = @user.cars.  
    erb :calc
end

get '/delete_description/:item' do
    @des = Calc.find(params[:item])
    @user_car = @des.car
    @des.destroy
    redirect "show_car/#{@user_car.id}/#{@user.id}"
end

post '/:car/:user/new_calc' do
     
     t_price = params[:gallons].to_f*params[:ppg].to_f
     mileage = params[:miles].to_f/params[:gallons].to_f
     @car = Car.find(params[:car])
     
     
     
     Car.find(params[:car]).calcs.create(miles: params[:miles], gallons: params[:gallons], ppg: params[:ppg], date: params[:date],mileage: mileage,t_price: t_price)
     @avg_ex = @car.calcs.average(:mileage)
     @car.update(mil_avg: @avg_ex)
     
     redirect "show_car/#{params[:car]}/#{params[:user]}"
end

post '/new_user' do
     @user = User.create(params)
     if @user.valid?
     	session[:name] = @user.name
     	redirect '/'
     else
	@message = @user.errors.full_messages.join(', ')
        erb :message_page
  end
end

get '/:car/chart' do
    erb :my_chart
end

post '/new_car' do
     @user.cars.create(car_description: params[:car])
     redirect "/#{params[:user]}"
end

get '/delete_user' do
    @user.destroy
    redirect '/'
end

get '/delete_car/:car' do 
       @car_description = Car.find(params[:car])
       @user = @car_description.user
       @car_description.destroy   
       redirect "/"
end






