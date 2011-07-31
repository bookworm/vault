require 'redcarpet'
module MongoMapperExt
  module FileWithPreview 
    def self.included(klass)
      klass.class_eval do 
        include MongoMapperExt::Markdown  
        extend ClassMethods
  
        key :desc, String
        mount_uploader :file, FileUploader      
        mount_uploader  :preview, PreviewUploader        
  
        markdown :desc, :parser => "redcarpet"   
      end  
    end   
    
    module ClassMethods
    end
  end    
end   

MongoMapperExt::FileWithPreview::ClassMethods.send(:include, CarrierWave::MongoMapper)