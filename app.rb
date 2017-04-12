require 'sinatra'
require 'pg'
load './local_env.rb' if File.exists?('./local_env.rb')

db_params = {
    host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['db_name'],
    user: ENV['user'],
    password: ENV['password']
}

db = PG::Connection.new(db_params)

get '/' do
	favoritedetails = db.exec("SELECT name, age, fav_num, second_fav_num, third_fav_num, fav_team, fav_color, fav_player, FROM favoritedetails");
	erb :index, locals: {favoritedetails: favoritedetails}

end

post '/favoritedetails' do
	name = params[:name]
	age = params[:age]
	fav_num = params[:fav_num]
	second_fav_num = params[:second_fav_num]
	third_fav_num = params[:third_fav_num]
	fav_food = params[:fav_team]
	fav_color = params[:fav_color]
	fav_movie = params[:fav_player]
	db.exec("INSERT INTO favoritedetails(name, age, fav_num, second_fav_num, third_fav_num, fav_team fav_color, fav_player) VALUES('#{name}', '#{age}', '#{fav_num}', '#{second_fav_num}', '#{third_fav_num}', '#{fav_team}', '#{fav_color}', '#{fav_player}')");
	redirect '/'
end

error message im getting when i try to run this.

# app.rb:13:in `initialize': could not translate host name "favoritedetails.cghc5iiuyixp.us-west-2.rds.amazonaws.com:5432" to address: nodename nor servname provided, or not known (PG::ConnectionBad)
# 	from app.rb:13:in `new'
# 	from app.rb:13:in `<main> 