var STK = STK || {};


$(function() {
    STK.responsive.optimizeImages();   
    
    /********************************
    *   commandline search
    *******************************/
    var posts = jQuery('.posts');
	//var commands = ['new', 'delete', 'edit'];
    var commandsJson = [
        {
            "name": "new",
            "type": "goto",
            "url": "/new",
            "arguments": [
                "note",
                "tag",
                "category"
            ]
        },
        {
            "name": "edit",
            "type": "goto",
            "url": "/new",
            "arguments": [
                "name",
                "id"
            ]
        }
    ];
    var currentCommand = "";
	
	$("#commandline").focus();    
	
	$("#commandline").keyup(function(evt){
	    var commandline = $(this);
	    var charCode = (evt.which) ? evt.which : evt.keyCode ;
        console.log(charCode);
        
        switch (charCode){
            case 8 : // delete
                if($('#commands').val().length == 0 && $('#valid-commands li').length > 0){
                    console.log($('#valid-commands li').length);
                    if($('#valid-commands li').length == 1){
                        currentCommand = "";
                        console.log("reset");
                    }
                    $('#valid-commands li:last').remove();
                    
                }
                $('.command-line-result').html('');
                break;
            
            case 13: //enter /new line = execute command
                
                var commands = $('#valid-commands li');
                //console.log(commands.eq(0).html());
    	
            	if(commands.length > 0){
                    if(commands.eq(0).html() == 'new'){
                        if(commands.eq(1).html() == 'note'){
                            window.location.href = "edit/note";
            	        }    
                    }	
            	}
                /*if($("#valid-commands li").length == 2){
                    if(currentCommand.type == "goto"){
                        var url = currentCommand.url;
                        var param = $("#valid-commands li:last").val();
                        window.location.href = url+"?p1="+param;    
                    }
                }*/
                break;
        }
        
        
        if(currentCommand == ""){
            for(var i = 0; i < commandsJson.length; i++){
    		    if($.trim($('#commands').val()) == commandsJson[i].name ){
        		    var command = $('<li class="valid command"></li>').html($('#commands').val());
            		$('#valid-commands').append(command);
            		currentCommand = commandsJson[i];
            		$('#commands').val('');
        		}	
    		}
        }else{
    	    for(var i = 0; i < currentCommand.arguments.length; i++){
    		    if($.trim($('#commands').val()) == currentCommand.arguments[i]){
        		    var command = $('<li class="valid command"></li>').html($('#commands').val().trim());
            		$('#valid-commands').append(command);
            		$('#commands').val('');
        		}	
    		}    	
		} 
		var commandlineinput = commandline.find('.command-input').val();
		
		if(commandlineinput.length > 2){
    		$.ajax( commandline.attr('data-get-url'), {
        	    data: {
            	    'q': commandline.find('.command-input').val()
        	    }	
    		}).done(function(data){
        		$('.command-line-result').html($(data).children('.note'));
        		$('.tags-result').html($(data).children('.tag'));
    		});
		}
		
		
	});


	$("#commandline").submit( function( event ){
    	event.preventDefault();
    	//var tag_name = $(this).children("#command-input").val();
    	console.log('stop stop stop');
    	
    	
    	/*console.log($(this).children('#taglist').find('option[value="'+tag_name+'"]').data('tag_id'));//
    	
    	var url = "?tag_name="+$(this).children("#command-input").val();
    	url += "&tag_id="+$(this).children('#taglist').find('option[value="'+tag_name+'"]').data('tag_id');
    	*/
    	
    	return false;
    });
    
    $('#note-tags-input').keyup(function(evt){
        var charCode = (evt.which) ? evt.which : evt.keyCode ;
        console.log(charCode);
        if(charCode === 39 || charCode == 9 || charCode == 13){
            var temp = $(this);
            console.log(temp.val());
            $('#taglist option').each(function(){
                if( $(this).html() === temp.val() ){
                    console.log($(this).data('value'))
            
                    var element = $('<li data-value="'+$(this).data('value')+'" class="note-tag"></li>').html( $(this).val() );
                    $(temp).val('');
                    $('#selected-tags').append(element); 
                    
                    var newRelatedInput = $('<input type="hidden" name="tags"/>').val($(this).data('value'));
                    $('#selected-tags').parent().append(newRelatedInput);    
                    
                }
            });
        }
        
        if(charCode === 32){ // 32 = space
            var temp = $(this);
            console.log(temp.val());
            var newTag = $('<li></li>').html(temp.val().trim());
            $('#selected-tags').append(newTag);
            $(this).val('');
            /*$('#taglist option').each(function(){
                if( $(this).html() === temp.val() ){
                    console.log($(this).data('value'))
            
                    var element = $('<li data-value="'+$(this).data('value')+'" class="note-tag"></li>').html( $(this).val() );
                    $(temp).val('');
                    $('#selected-tags').append(element); 
                    
                    var newRelatedInput = $('<input type="hidden" name="tags"/>').val($(this).data('value'));
                    $('#selected-tags').parent().append(newRelatedInput);    
                    
                }
            });*/        
        }
        
        if(charCode === 8){
            var lastElement = $('#selected-tags li:last');
            $('input[value="'+lastElement.attr('data-value')+'"]').remove();
            lastElement.remove();
        }
    });
    
    $('.insert-form form').submit(function(form){
        console.log($('#selected-tags li'));
        // serialize li
        var tags = "";
        $('#selected-tags li').each(function(index, data){
            tags += $(data).text() + ',';
        });
        var inputelement = $('<input type="hidden" name="validtags" value=""/>');
        inputelement.val(tags);
        $(this).append(inputelement);   
    });
     
    /*
$('.tinymceMe').tinymce({
        toolbar:'bold,link,italic,list',
        plugin:'autoresize'
    });
*/
    
    /*
/*strect textarea
    var txt = $('.autoResize'),  
        hiddenDiv = $(document.createElement('div')),  
        content = null;  
  
    txt.addClass('txtstuff');  
    hiddenDiv.addClass('hiddendiv common');  
  
    $('body').append(hiddenDiv);  
  
    txt.on('keyup', function () {  
  
        content = $(this).val();  
  
        content = content.replace(/\n/g, '<br>');  
        hiddenDiv.html(content + '<br class="lbr">');  
  
        $(this).css('height', hiddenDiv.height());  
  
    });​  
*/
    
});
tinymce.init({
    selector: ".tinymceMe",
    plugins: 'code, image, link',
    closed : /^(br|hr|input|meta|img|link|param|area)$/,

 });







