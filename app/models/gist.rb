require 'octokit'
class Gist
  include MongoMapper::EmbeddedDocument  
  plugin MongoMapper::Plugins::Timestamps     
  
  # Keys
  key :gist_id,     String
  key :files,       Hash    
  key :description, String   
  key :public,     Boolean
  
  before_save :create_gist     
  
  def embed()
    %Q{<script src='https://gist.github.com/#{self[:gist_id]}.js'></script>}
  end
  
  def create_gist()
    if !self[:gist_id]
      gist = Octokit.create_gist(self[:description], self[:public], self[:files])  
      self[:gist_id] = gist.id  
    else
      gist = Octokit.gist(self[:gist_id])    
      
      self[:public]      = gist.public
      self[:description] = gist.description
    end  
    self[:files] = gist.files  
  end   
end