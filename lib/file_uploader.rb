class FileUploader < CarrierWave::Uploader::Base            
  include CarrierWave::RMagick

  ##
  # Storage type
  #   
  storage :file   
  storage :s3 if Padrino.env == :production   
   
  configure do |config|         
    config.s3_cnamed = true
    config.s3_access_key_id     = ENV['S3_ACCESS_KEY']
    config.s3_secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
    config.s3_bucket =  ENV['S3_BUCKET']          
  end
  
  ## Manually set root
  def root; File.join(Padrino.root,"public/"); end

  ##
  # Directory where uploaded files will be stored (default is /public/uploads)
  # 
  def store_dir
    return 'uploads/files' if Padrino.env == :development
    return 'files' if Padrino.env == :production  
  end

  ##
  # Directory where uploaded temp files will be stored (default is [root]/tmp)
  # 
  def cache_dir
    Padrino.root("tmp")
  end

  def extension_white_list
    %w(psd rar zip gz tar.gz tar txt md pdn pgn)
  end 
end