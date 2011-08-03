module MongoMapperExt
  module Text 
    def self.included(klass)
      klass.class_eval do  
        
        key :preview,     String
        key :preview_src, String 
        mount_uploader :file, FileUploader
        
        def gen_preview()
          if self.file  
            if self.file.markdown_types.include?(self.file.file.extension)
              self.preview = self.file.read 
              self.preview_src = self.preview
              self.preview = Redcarpet.new(self.preview).to_html
            end   
          end
        end
      end
    end
  end
end  

class Text < Document  
  include MongoMapperExt::Text 
    
  # Key Settings
  slug_key :title, :unique => true 
  
  # Callbacks  
  before_save :gen_preview
end