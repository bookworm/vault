module MongoMapperExt
  module Task 
    def self.included(klass)
      klass.class_eval do
        #extend ClassMethods       

        # Keys   
        key :status,         String
        key :note,           String   
        key :note_intro,     String
        key :start_date,     Date
        key :due_date,       Date 
        key :estimated_time, Float
        key :actual_time,    Float
        key :archived_date,  Date
        key :canceled_date,  Date
        key :priority,       Integer
        key :archived,       Boolean
        key :canceled,       Boolean    
        key :completed,      Boolean, :default => false
        key :completed_date, Date
        key :repeating,      Boolean 
				key :started,        Boolean, :default  => false  
      end
    end  
  end 
end    

class Task < Document    
  include MongoMapperExt::Task

  # Key Settings
  slug_key :title, :unique => true 
  
  # Callbacks 
  before_save :set_path
end