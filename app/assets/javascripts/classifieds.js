$(function(){
	$('#edit_selected').click(function(){
		selected = $("input:radio[name=edit]:checked");
		if(selected.length > 0){
			url = selected[0].value;
			window.location = url;
		}	
		return false;
	});

	$('#delete_selected').click(function(){
		selected = $("input:checkbox[name=delete]:checked");
		var l = selected.length
		if(l > 0){

			id_array = new Array(l)
			for(var i = 0; i < l ; i++){
				id_array[i] = selected[i].value
			}
			window.location = "/classifieds/delete_selected?ids="+id_array
			// $.ajax({
			// 	url: "/classifieds/delete_selected",
			// 	type: "delete",
			// 	data: {
			// 		ids: id_array
			// 	}
			// });	
		}		
		return false;
	});

});