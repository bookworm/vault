class CoverUploader < CarrierWave::Uploader::Base            
  include CarrierWave::RMagick

  ##
  # Storage type
  #   
  storage :file
   
	   
  # configure do |config|         
  # c config.s3_cnamed = true
  # c config.s3_access_key_id     = ENV['S3_ACCESS_KEY']
  # c config.s3_secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
  # c config.s3_bucket =  ENV['S3_BUCKET'] 
  # cnd
  
  ## Manually set root
  def root; File.join(Padrino.root,"public/"); end

  ##
  # Directory where uploaded files will be stored (default is /public/uploads)
  # 
  def store_dir
    'images/uploads/covers'
  end

  ##
  # Directory where uploaded temp files will be stored (default is [root]/tmp)
  # 
  def cache_dir
    Padrino.root("tmp")
  end

  ##
  # Default URL as a default if there hasn't been a file uploaded
  # 
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  process :resize_to_fit => [632, 959]

  version :thumb do
    process :resize_to_fill =>[196,310]
  end 
  
  version :large do
    process :resize_to_fill =>[316,550]
  end   

  def filename
    return '' << self.model.isbn << '.jpg' if self.model.isbn 
    return '' << self.model.title << '.jpg' if self.model.title
    ''
  end  

	def url
		string = ''
		string << 'http://' << s3_bucket if Padrino.env == :production  
		string << '/' << store_dir << '/' << version_name.to_s << '_' << filename 
	end
end