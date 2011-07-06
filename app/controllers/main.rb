IdeaVault.controllers :main, :cache => true, :expires_in => 300 do

	get :index, :map => '/' do     
		@docs = Document.all(:depth => 0)
		render 'index'
	end     
	
	get :show_doc, :map => '/documents/:slug' do
		@doc = Document.first(:slug => params[:slug])  
		render "documents/#{@doc.template.full.to_sym}"
	end
  
end 