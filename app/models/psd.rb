require 'google/book'
module MongoMapperExt
  module Psd 
    def self.included(klass)
      klass.class_eval do
        include MongoMapperExt::FileWithPreview  
        slug_key :title, :unique => true          
      end
    end
  end
end

class Psd < Document  
  include MongoMapperExt::Psd               
end