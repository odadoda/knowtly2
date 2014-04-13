var STK = STK || {};


$(function() {
    STK.responsive.optimizeImages();   
    
    /********************************
    *   commandline search
    *******************************/
    var posts = jQuery('.posts');
	
	$("#commandline").focus();    
	
	$("#commandline").keyup(function(evt){
	    var charCode = (evt.which) ? evt.which : evt.keyCode ;

		if(charCode != 13){

    		var querystrig = jQuery(this).val();
    		
    		if( querystrig.length > 1 ){
    		
    			jQuery.ajax({
    				type:"post",
    				dataType:"html",
    				url:pewpew.ajaxurl,
    				data:{action:"pewpew_search", s:querystrig},
    				success: function(response){
    				    jQuery('#main-post-list').html(response);
    				}
                });
                
    		}
		}
	});


	$("#commandline").submit( function( event ){
    	event.preventDefault();
    	var url = "?tag="+$(this).children("#command-input").val();
    	window.location.href = url;
    	return false;
    });

});