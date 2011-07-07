require 'google/book'
module MongoMapperExt
  module Book 
    def self.included(klass)
      klass.class_eval do
        #extend ClassMethods 
  
        # Keys.  
        key :sub_title,    String
        key :isbn,         String   
				key :desc,         String  
				key :google_link,  String 
				key :preview_link, String
        
        # Key Settings.
        mount_uploader :cover, CoverUploader       

				def gen_meta() 
					begin 
						if self.isbn  
							entries = Google::Book.search(self.isbn) 
						else
							entries = Google::Book.search(self.title)      
						end
						entry   = entries.first     
						self.title            = entry.title
						self.isbn             = entry.isbn
						self.google_link      = entry.info
						self.desc             = entry.description
						self.preview_link     = entry.preview  
					  self.remote_cover_url = entry.cover.extra_large
					rescue  
						nil
					end
				end   
      end
    end  
  end
end   

class Book < Document      
  include MongoMapper::Document
  include MongoMapperExt::Book  

  # Callbacks 
  before_save :set_path, :gen_meta
end