module FileWithPreview  
  include MongoMapperExt::Markdown 
  
  key :desc, String
  mount_uploader :file, FileUploader      
  mount_uploaer  :preview, PreviewUploader        
  
  markdown :desc, :parser => "redcarpet"
end