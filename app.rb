#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index			
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	hh = {
		:username => 'Enter correct name',
		:phone => 'Enter correct phone',
		:datetime => 'Enter correct date',
		:time => 'Enter correct time'
	}

	@error = hh.select { |k,_| params[k] == '' }.values.join(", ")
	if @error != ''
		return erb :visit
	end

	c = Client.new
	c.name = @username
	c.phone = @phone
	c.datestamp = @datetime
	c.barber = @barber
	c.color = @color
	c.save

	erb "<h2>Thank you, we are waiting for you!</h2>"
end