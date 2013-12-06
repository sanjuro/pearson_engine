config['mongo'] = EventMachine::Synchrony::ConnectionPool.new(size: 20) do
	conn = EM::Mongo::Connection.new('localhost', 27017, 1, {:reconnect_in => 1})
	conn.db('Pearson')
end