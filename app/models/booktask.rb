class Booktask < Task   
  include MongoMapperExt::Book     
  
  # Key Settings
  slug_key :title, :unique => true 
  
  # Callbacks 
  before_save :set_path, :gen_meta
end