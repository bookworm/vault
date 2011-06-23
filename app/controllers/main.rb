IdeaVault.controllers :main, :cache => false do 

	get :index, :map => '/' do     
		# expires_in 60
		@docs = Document.all(:depth => 0)
		render 'index'
	end     
	
	get :show_doc, :map => '/documents/:slug' do
		@doc = Document.first(:slug => params[:slug])  
		render "documents/#{@doc.template.full.to_sym}"
	end
  
end 