require 'yajl'  
IdeaVault.controllers :api, :cache => false do  
  
  before do
    unless @env['REMOTE_ADDR'] == '127.0.0.1' || @env['REMOTE_ADDR'] == ENV['IP_ACCESS'] 
      halt 403, "Not Authorized"
    end
  end
	
	put :import do 
		file = params[:file][:tempfile]    
		type =  params[:file][:type]   
		file_string = file.read
		if type.match(/yaml/i) || type.match(/yml/i)    
			parsed = YAML.load(file_string)
			@doc = Document.new(parsed)  
		elsif type.match(/json/i)   
			@doc = Document.from_json(file_string)         
		else
			halt 415, "Upload Either JSON or YAML" 
		end	 
		
		if @doc.save
      'Document Saved'
    else
      @doc.errors.full_messages   
    end
	end 
end  