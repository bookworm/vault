class IdeaVault < Padrino::Application
  register Padrino::Helpers
  register Padrino::Rendering   
  register Padrino::Admin::AccessControl
  register CompassInitializer
  register AssetHatInitializer  
  enable :sessions
  enable :caching  

end