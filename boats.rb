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

	results = connect.exec("SELECT bname, color
			FROM boats")

	# print column names
	puts results.fields().join(',')

	# print each row of result set
	
	results.each do |row|
	    #unless row  == nil
		puts row['bname'] + " " + row['color']
  	    #end
	end

	connect.close

rescue PG::Error => err
	puts err
end









