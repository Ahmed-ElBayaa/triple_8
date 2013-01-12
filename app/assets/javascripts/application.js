// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery_nested_form
//= require twitter/bootstrap
//= require_tree .

function add_currency (countries){
	options = ""
	for(var i =1; i < countries.length ; i++){
		options += '<option value="'+countries[i][0]+'">'+countries[i][1]+'</option>';
	}
	var i = Math.floor(Math.random()*100);
	$('.new_currency').siblings('table').append('<tr><td><label for="Name">Name</label>'+
		'<input id="new_'+i+'_unit" name="new['+i+'[unit]]" type="text"></td>'+
		'<td><label for="Ratio_to_dollar">Ratio to dollar</label>'+
		'<input id="new_'+i+'_ratio" name="new['+i+'[ratio]]" step="0.001" type="number"></td>'+
		'<td><label for="Country">Country</label><select class="select" name="new['+i+
		'[country_id]]"><option value="">Select country</option>'+ options +
		'</td><td><a href="#" onclick="remove_currency('+i+'); return false;">remove</a></td><tr>'
		);        
}

function remove_currency (i){
	$('#new_'+i+'_unit').parents('tr').remove();
}

$(document).ready(function(){
	
	$(".date").datepicker({ 
		dateFormat: 'dd-mm-yy',
		changeMonth : true,
        changeYear : true
	});

	$('#classified_main_category_id').change(function(){
		$.ajax({
			url: "/classifieds/change_sub_categories",
			data: {main_category: $(this).val()}
		});
	});

	$('#search_main_category_name_contains').change(function(){
		$.ajax({
			url: "/classifieds/change_sub_categories_for_search",
			data: {main_category: $(this).val()}
		});
	});
});