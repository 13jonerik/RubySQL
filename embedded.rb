#!/usr/bin/env ruby

require 'pg'
begin
	#create our db connection
	connect = PGconn.connect(
		:host => "dbclass.cs.pdx.edu",
		:dbname => "f15ddb41",
		:user => "f15ddb41",
		:password => "*")

	#… do stuff on next slide …

	results = connect.exec("SELECT sid
			FROM sailors")

	# print column names
	puts results.fields().join(',')

	# print each row of result set
	results.each do |row|
		puts row['sid']
	end

	connect.close

rescue PG::Error => err
	puts err
end



