require 'redcarpet'
module MongoMapperExt
  module Idea
    def self.included(klass)
      klass.class_eval do  
        
        # Keys                
        key :body,           String
        key :body_processed, String
        key :intro,          String    
        
        def parse_markdown()
          markdown = Redcarpet.new(self[:body])
          self[:body_procesed] = markdown.to_html
        end
      end
    end
  end
end     

class Idea < Document    
  include MongoMapper::Document
  include MongoMapperExt::Idea
  
  has_many :gists   
  
  before_save :parse_markdown
end