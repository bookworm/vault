class Psd < Document
  include MongoMapperExt::FileWithPreview     
  
   # Key Settings
  slug_key :title, :unique => true                                 
end