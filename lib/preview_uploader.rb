class PosterUploader < CarrierWave::Uploader::Base            
  include CarrierWave::RMagick

  ##
  # Storage type
  #   
  storage :file if Padrino.env == :development        
  storage :s3 if Padrino.env == :production           
  
  configure do |config|         
    config.s3_cnamed = true
    config.s3_access_key_id     = ENV['S3_ACCESS_KEY']
    config.s3_secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
    config.s3_bucket =  ENV['S3_BUCKET']          
  cnd 

  ## Manually set root
  def root; File.join(Padrino.root,"public/"); end

  ##
  # Directory where uploaded files will be stored (default is /public/uploads)
  # 
  def store_dir
    'uploads/previews' if Padrino.env == :development
    'previews' if Padrino.env == :production
  end

  ##
  # Directory where uploaded temp files will be stored (default is [root]/tmp)
  # 
  def cache_dir
    Padrino.root("tmp")
  end

  process :resize_to_fit => [2000,2000]

  version :thumb do
    process :resize_to_fill =>[196,310]
  end 
  
  version :large do
    process :resize_to_fit =>[800,600]
  end 

	def url
		string = ''
		string << 'http://' << s3_bucket if Padrino.env == :production  
		string << '/' << store_dir << '/' << version_name.to_s << '_' << filename 
	end
end 