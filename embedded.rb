require ‘pg’
begin
	#create our db connection
	connect = PGconn.connect(
		:host => “dbclass.cs.pdx.edu”,
		:dbname => “f15ddb41”,
		:user => “f15ddb41”,
		:password => “******”)

	#… do stuff on next slide …

	connect.close

rescue PG::Error => err
