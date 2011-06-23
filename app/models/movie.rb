require 'ruby-tmdb'
Tmdb.api_key = ENV["TMDB_API_KEY"]
module MongoMapperExt
  module Movie 
    def self.included(klass)
      klass.class_eval do 
        
        # Keys.
        key :name,        String
        key :imdb_id,     String
        key :desc,        String
        key :imdb_url,    String 
        key :trailer,     String
        key :tmdb_id,     String   
        key :genres,      Array         
        
        # Key Settings.
        mount_uploader :poster, PosterUploader
        
        def gen_movie_info()       
          begin
            tmdb = TmdbMovie.find(:title => self[:title], :limit => 1)
            self[:name]     = tmdb.name   
            self[:desc]     = tmdb.overview
            self[:trailer]  = tmdb.trailer                
            self[:imdb_id]  = tmdb.imdb_id
            self[:imdb_url] = "http://www.imdb.com/title/#{tmdb.imdb_id}"   
            self[:tmdb_id]  = tmdb.id
            self[:genres]   = tmdb.categories.map { |cat| cat.name }   
            self.remote_poster_url = tmdb.posters.first.url     
          rescue
            nil
          end
        end 
      end
    end
  end
end

class Movie < Document    
  include MongoMapper::Document
  include MongoMapperExt::Movie
  
  # Callbacks
  before_save :gen_movie_info
end