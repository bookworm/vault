IdeaVault.helpers do
  
  def task_class(task= nil, index=nil)        
    task  = @task if !task
    index = @index if !index      
    index +=1   
    
  	klass = ['book-task-item']
  	klass << 'task-item'         

		klass << 'first'     if index % 5 == 0 || index == 1
		klass << 'last'      if index % 4 == 0 
	
  	klass << 'completed' if task[:completed] == true  
  	klass << 'no-note'   if task[:note].to_s.empty?  
  	   
  	klass.join(' ')
  end      
  
  def book_tasks
		btasks = @doc.children
		rstring = ""    
		
		openstring = <<-EOS
		<div class='group'>
			<ul class='booktasks'>
		EOS
		closestring = <<-EOS   
		</ul>
		</div>
		EOS
		rstring << openstring
		btasks.each_with_index do |@task, @index|
			rstring << closestring << openstring if @index % 4 == 0 && @index != 0      
			rendered = partial 'documents/booktask_full'
			rstring << rendered
		end    
		rstring << closestring
		return rstring
	end     
end