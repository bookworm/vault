module MongoMapperExt
  module Text 
    def self.included(klass)
      klass.class_eval do  
        include MongoMapperExt::Markdown  
  
        key :preview, String 
        markdown :preview, :parser => "redcarpet"   
        mount_uploader :file, FileUploader    
      end
    end
  end
end  

class Text < Document  
  include MongoMapper::Document
  include MongoMapperExt::Text
end