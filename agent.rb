#!/usr/bin/env ruby

require 'pg'
begin

	#Hide Password
	file = File.open("../Desktop/password.rb", "rb")
	pword = file.read.chomp

	#create our db connection
	connect = PGconn.connect(
		:host => "dbclass.cs.pdx.edu",
		:dbname => "f15ddb41",
		:user => "f15ddb41",
		:password => pword)

	#… do stuff on next slide …

	results = connect.exec("SELECT agent_id, salary 
			FROM agent ORDER BY
			salary DESC")

	# print column names
	puts results.fields().join(',')

	# puts results[3]['salary]

	records = results.count - 2

	for i in 1..records
		ave = (results[i-1]['salary'].to_i + results[i+1]['salary'].to_i) / 2
		if results[i]['salary'].to_i < ave then
			# insert row into raise db
		end
	end 

	connect.close

rescue PG::Error => err
	puts err
end


