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

	#create a cursor on agents list
	results = connect.exec("SELECT agent_id, salary 
			FROM agent ORDER BY
			salary DESC")

	# print column names
	puts results.fields().join(',')

	#for purpose of demo, drop table if exists and remake 
	connect.exec("DROP TABLE IF EXISTS agent_raise")

	#create the agent_raise table
	connect.exec("CREATE TABLE agent_raise (
				agent_id INT,
				raise INT)")

	#save number of records in var numRecords
	numRecords = results.count - 2

	
	#move cursor through the table, compare salaries, add to agent_raise if necessary
	for i in 1..numRecords
		ave = (results[i-1]['salary'].to_i + results[i+1]['salary'].to_i) / 2
		if results[i]['salary'].to_i < ave then
			raiseNum = ave - results[i]['salary'].to_i
			id    = results[i]['agent_id'].to_i
			connect.exec_params('INSERT INTO agent_raise (agent_id, raise) VALUES ($1,$2)', [id, raiseNum])	
		end
	end 

	#handle edge case - lowest paid agent gets raise equal to diff. of next highest (one tied)
	agentLow = results[numRecords-1]['salary'].to_i - results[numRecords+1]['salary'].to_i
	agentLowID = results[numRecords+1]['agent_id'].to_i
	connect.exec_params('INSERT INTO agent_raise (agent_id, raise) VALUES ($1,$2)', [agentLowID, agentLow])	

	connect.close

rescue PG::Error => err
	puts err
end


