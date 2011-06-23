class Template
  include MongoMapper::Document
  
	# Keys
  key :name,     String  
	key :preview,  String
	key :full,     String   
	key :full_css, String    
	key :view,     String
	
	def initialize(args)
    super(args)
    self.preview ||= '' << self.name.downcase  << '_' << 'preview' 
    self.full    ||= '' << self.name.downcase << '_' << 'full'    
		self.view    ||= self.name  
  end 
end