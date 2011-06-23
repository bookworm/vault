MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'idea_vault_development'
  when :production  then MongoMapper.database = 'idea_vault_production'
  when :test        then MongoMapper.database = 'idea_vault_test'
end