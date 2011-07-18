require 'pp'
class Document
  include MongoMapper::Document  
  include MongoMapperExt::Slugizer 
  plugin MongoMapper::Plugins::Timestamps      

  ##
  # Keys.  
  
  ## Main Keys
  key :title,       String, :unique => true
  key :tags,        Array       
  key :doc_status,  String, :default => 'public'     
  key :template_id, ObjectId                 
  
  # Keys for nesting.  
  key :root_id,   ObjectId
  key :parent_id, ObjectId       
  key :depth,     Integer, :default => 0
  key :path,      Array  
  
  ## Very special key NOTHING is EVER SAVED to it, only used during mapping.
  key :documents, Array
  
  timestamps!  
  
  # Key Settings
  slug_key :title
  
  # Associations
  one :template     

  # Callbacks 
  before_save :set_path, :set_default_template     
 
  ##
  # Getter and Setter Methods 
  #                   
  
  def url()   
    'http://' << ENV['DOMAIN'] << '/' << self.slug
  end
  
  # Called Saving The Tags
  def tags=(t)
    if t.kind_of?(String)
      t = t.downcase.split(",").join(" ").split(" ").uniq
    end
    self[:tags] = t
  end
   
  # Template
  def template=(t)
		if t.is_a?(String)
			t2 = Template.first(:name => t)    
		elsif t.is_a?(Hash)
			t2 = Template.new(t)
			t2.save  
		elsif t.is_a?(Template)
			t2 = t 	
		end       
		self[:template_id] = t2._id 
	end  
	
	def template()
		Template.first(:id => self[:template_id])
	end   
	
	# Child Documents
  def children(limit=0) 
    return Document::threaded_with_field(self,'created_at','public',limit)
  end     

  def children=(children)           
		self.save unless Document.find(:id => self._id)  
		if self['childtype'] 
			childtype = self['childtype']
		else 
			childtype = 'document'   
		end 
		children.each do |child|   
			childtype = child['type'] if child['type']   
			childr = self.send("add_#{childtype}".to_sym, child)  
		  childr.save
		end
	end
  
  ## 
  # Collection methods
  #
  
  # Return an array of documents, threaded.
  def self.threaded_with_field(document, field_name='created_at', status='public', limit=0)
    documents = Document.all(:conditions => {:doc_status => status, :root_id => document.id}, :limit => limit, :order => [:path.asc, field_name.to_sym.asc])
		results, map  = [], {}
    documents.each do |doc| 
      if doc.parent_id.blank? || doc.depth == 0 || document._id == doc.parent_id  
        results << doc
      else        
        map[doc.parent_id.to_s] ||= []
        map[doc.parent_id.to_s] << doc      
      end     
    end        
    assemble(results, map)        
  end   
  
  # We should use the map when looping through.
  # If the document has stuff in the map we ouput it into the parent.
  
  # Recursive method to loop over and map the documents.
  def self.assemble(results, map)     
    list = [] 
    results.each do |result|
      if map[result.id.to_s]    
        list << result   
        result[:documents] += self.assemble(map[result.id.to_s], map) 
      else    
        list << result
      end
    end
    list
  end 
  
  ##
  # Instance Methods
  # 
  
  # Catches an add method call
  def method_missing(method, *args, &block)     
    if method.to_s.include?('add_')      
      type = method.to_s.gsub!('add_', '').to_s.capitalize   
      docClass = Object.const_get(type)   
      options = { :parent_id => self.id}            
      if self.root_id == nil    
        options[:root_id] = self.id
      else
        options[:root_id] = self.root_id 
      end
      options = args.extract_options!.merge(options) 
      return docClass.new(options)
    else
      super
    end   
  end

  def set_path  
    if !self.parent_id.blank?    
      parent = Document.find(self.parent_id)    

      if parent.root_id.blank?        
		    self.root_id = self.parent_id  
	    else
	      self.root_id = parent.root_id  
			end
      self.depth = parent.depth + 1
      self.path  = parent.path              
      self.path  << parent.id.to_s     
    end     
  end   

  def set_default_template()
		if self.template_id.blank?   
			t = Template.first(:name => self._type) 
			t = Template.first(:name => 'Document') unless t   
			self.template_id = t._id    
		end
	end       
end