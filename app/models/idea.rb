require 'redcarpet'  
class Idea < Document    
  include MongoMapper::Document
  include MongoMapperExt::Markdown
  
  # Keys
  key :body,  String
  key :intro, String     
  
  # Key Settions
  markdown :body, :intro, :parser => 'redcarpet'
    
  # Associations
  has_many :gists   
end