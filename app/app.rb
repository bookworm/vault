class IdeaVault < Padrino::Application
  register Padrino::Helpers
  register Padrino::Rendering   
  register Padrino::Cache
  register CompassInitializer
  register AssetHatInitializer  
  enable :caching if Padrino.env == :production
  
  set :cache, Padrino::Cache::Store::Redis.new(::Redis.new)  if Padrino.env == :production
end