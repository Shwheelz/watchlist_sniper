require 'green_shoes'
require 'pstore'
require 'encrypted_strings'

store = PStore.new("data.pstore")		

$username = store.transaction { store.fetch(:username, "abc1234") }
encrypted_password = store.transaction { store.fetch(:password, "") }
if encrypted_password != ""
	$password = encrypted_password.decrypt(:symmetric, :algorithm => 'des-ecb', :password => 'asymmetric') 
end
$course_number = store.transaction { store.fetch(:course_number, "123456") }

Shoes.app title: "PSU Watchlist Script", height: 275 do

	para 'Username: '
	@username_field = edit_line text: $username do
		$username = @username_field.text
	end

	para 'Password: '
	@password_field = edit_line text: $password, secret: true do
		$password = @password_field.text
	end

	para 'Course Number: '
	@course_number_field = edit_line text: $course_number do 
		$course_number = @course_number_field.text
	end

	para ''
	@remember_me = check; para "Remember me", width: 200

	para ''
	@start = button("Sign Up") do
		if @remember_me.checked?
			store.transaction do
				store[:username] = $username				
				store[:password] = $password.encrypt(:symmetric, :algorithm => 'des-ecb', :password => 'asymmetric')
				store[:course_number] = $course_number
			end
		end
		load 'WatchlistSniper.rb'
	end
end

