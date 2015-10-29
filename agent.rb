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


	connect.exec("DROP TABLE IF EXISTS agent_raise")

	connect.exec("CREATE TABLE agent_raise (
				agent_id INT,
				raise INT)")

	records = results.count - 2

	for i in 1..records
		ave = (results[i-1]['salary'].to_i + results[i+1]['salary'].to_i) / 2
		if results[i]['salary'].to_i < ave then
			raiseNum = ave - results[i]['salary'].to_i
			id    = results[i]['agent_id'].to_i
			connect.exec_params('INSERT INTO agent_raise (agent_id, raise) VALUES ($1,$2)', [id, raiseNum])	
			#connect.exec_prepa('addRecord', [id, raiseNum])
			#connect.exec('DEALLOCATE addRecord')
		end
	end 

	connect.close

rescue PG::Error => err
	puts err
end


