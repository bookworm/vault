var converter = new Showdown.converter();       
                                                
function getTemplate(path)
{ 
	var source;
  var template;
	$.ajax({
		url: path,
		cache: true, 
		async: false,
		success: function(data) {
			source    = data;
			template  = Handlebars.compile(source);   
		}               
  });  
	return { source: source, template: template}
}
 
$(document).ready(function($) {
	$('.view-note').click(function() {  
    
    /**
     * Overlay div. Dark and Evil goodness. Don't you just love a good oxymoron? 
     * It gives me an awesome feeling; or is that oxycotin I'm thinking of?  
     * Drug humor -- definitely something you don't expect to find in JS comments.
     **/ 
    var darkness = '<div id="darkness" style="display: none; cursor: pointer; '
                 + ' position: absolute; height: auto; width: 920px; z-index:500;"></div>';  
    $('body').prepend(darkness);  
    
    var offset = $(this).parent().parent().parent().parent().offset();           
    offsetTop = offset.top;  
    offsetLeft = offset.left;
    $('#darkness').css({ top : offsetTop + 25, left : offsetLeft - 70})         
    
    /** Note Markup Grabbing **/
    var noteTxt    = $(this).next().html();  
    noteTxt        = converter.makeHtml(noteTxt);

	  var source   = getTemplate('/templates/note.mustache');   
	  var template = source.template; 
	  source       = source.source;
		var data = { note: noteTxt }; 
       
    $('#darkness').append(template(data));
    $('#darkness').fadeIn('slow');        

    $('#close-note, body, #darkness').click(function() {   
      $('#darkness').fadeOut('slow').remove();    
      return false;
    });
    return false;
  });
});