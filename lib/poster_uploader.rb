class PosterUploader < CarrierWave::Uploader::Base            
  include CarrierWave::RMagick

  ##
  # Storage type
  #   
  storage :file

  ## Manually set root
  def root; File.join(Padrino.root,"public/"); end

  ##
  # Directory where uploaded files will be stored (default is /public/uploads)
  # 
  def store_dir
    'images/uploads/posters'
  end

  ##
  # Directory where uploaded temp files will be stored (default is [root]/tmp)
  # 
  def cache_dir
    Padrino.root("tmp")
  end

  process :resize_to_fit => [632, 959]

  version :thumb do
    process :resize_to_fill =>[196,310]
  end 
  
  version :large do
    process :resize_to_fill =>[316,550]
  end   

  def filename
    return '' << self.model.imdb_id << '.jpg' if self.model.imdb_id
    ''
  end  

	def url
		string = ''
		string << 'http://' << s3_bucket if Padrino.env == :production  
		string << '/' << store_dir << '/' << version_name.to_s << '_' << filename 
	end
end