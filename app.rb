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
	favoritedetails = db.exec("SELECT name, age, fav_num, second_fav_num, third_fav_num, fav_team, fav_color, fav_player FROM favoritedetails");
	erb :index, locals: {favoritedetails: favoritedetails}

end

post '/favoritedetails' do
	name = params[:name]
	age = params[:age]
	fav_num = params[:fav_num]
	second_fav_num = params[:second_fav_num]
	third_fav_num = params[:third_fav_num]
	fav_team = params[:fav_team]
	fav_color = params[:fav_color]
	fav_player = params[:fav_player]
	db.exec("INSERT INTO favoritedetails(name, age, fav_num, second_fav_num, third_fav_num, fav_team, fav_color, fav_player) VALUES('#{name}', '#{age}', '#{fav_num}', '#{second_fav_num}', '#{third_fav_num}', '#{fav_team}', '#{fav_color}', '#{fav_player}')");
	redirect '/'
end

post '/update_column' do
	new_data = params[:new_data]
	old_data = params[:old_data]
	column = params[:table_column]

	case column
	when 'name'
		db.exec("UPDATE favoritedetails SET name = '#{new_data}' WHERE name = '#{old_data}'");
	when 'age'
		db.exec("UPDATE favoritedetails SET age = '#{new_data}' WHERE age = '#{old_data}'");
	when 'fav_num'
		db.exec("UPDATE favoritedetails SET fav_num = '#{new_data}' WHERE fav_num = '#{old_data}'");
	when 'second_fav_num'
		db.exec("UPDATE favoritedetails SET second_fav_num = '#{new_data}' WHERE second_fav_num = '#{old_data}'");
	when 'third_fav_num'
		db.exec("UPDATE favoritedetails SET third_fav_num = '#{new_data}' WHERE third_fav_num = '#{old_data}");
	when 'fav_team'
		db.exec("UPDATE favoritedetails SET fav_team = '#{new_data}' WHERE fav_team = '#{old_data}");
	when 'fav_color'
		db.exec("UPDATE favoritedetails SET fav_color = '#{new_data}' WHERE fav_color = '#{old_data}");
	when 'fav_player'
		db.exec("UPDATE favoritedetails SET fav_player = '#{new_data}' WHERE fav_player = '#{old_data}");
	end
		redirect '/'
end

post '/delete_table' do
	db.exec("DETELE FROM column");
	redirect '/'
end
