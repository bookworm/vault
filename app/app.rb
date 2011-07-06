class IdeaVault < Padrino::Application
  register Padrino::Helpers
  register Padrino::Rendering   
  register Padrino::Admin::AccessControl       
  register Padrino::Cache
  register CompassInitializer
  register AssetHatInitializer  
  enable :sessions      
  enable :caching if Padrino.env == :production
  
  set :cache, Padrino::Cache::Store::Redis.new(::Redis.new)
end