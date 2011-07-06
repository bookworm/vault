IdeaVault.controllers :main, :cache => true do
  expires_in 600 if Padrino.env == :production  
  expires_in 0 if Padrino.env == :development 

	get :index, :map => '/' do     
		@docs = Document.all(:depth => 0)
		render 'index'
	end     
	
	get :show_doc, :map => '/documents/:slug' do
		@doc = Document.first(:slug => params[:slug])  
		render "documents/#{@doc.template.full.to_sym}"
	end
  
end 