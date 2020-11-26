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

	@title = 'Good!'
	@message = "<h2>Tfck you, you are confirmed epta!</h2>"
	erb :message

	u = Client.new :name => @username
	u.save if u.new_record?
	p = Client.new :phone => @phone
	p.save if u.new_record?
	d = Client.new :datestamp => @datetime
	d.save if u.new_record?
	b = Client.new :barber => @barber
	b.save if u.new_record?
	c = Client.new :color => @color
	c.save if u.new_record?
end