$(function(){

	$('#edit_selected').click(function(){

		var selected = $("input:radio[name=edit]:checked");

		if(selected.length > 0){
			var url = $(selected[0]).data('url');
			window.location = url;
		}	
		return false;

	});

	$('#delete_selected').click(function(){	

		var ids = $.map($("input:checkbox[name=delete]:checked"),function(e){return $(e).data('id')});

		var l = ids.length;
		if(l > 0){

			var confirmMessage = $(this).data('confirm');
			var locale = window.location.pathname.split('/')[1];
			
			if( confirm(confirmMessage) ){							
				url = "/classifieds/delete_selected?locale="+locale+"&ids="+ids ;
				alert(url);
				window.location = url;	
			}

		}		
		return false;
	});

});