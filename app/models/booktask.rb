class Booktask < Task   
  include MongoMapper::Document
  include MongoMapperExt::Book  

  # Callbacks 
  before_save :set_path, :gen_meta
end