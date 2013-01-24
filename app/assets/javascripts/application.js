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

$(document).ready(function(){
	
	$(".date").datepicker({ 
		dateFormat: 'dd-mm-yy',
		changeMonth : true,
        changeYear : true
	});

	$('#classified_main_category_id').change(function(){
		$.ajax({
			url: "/classifieds/change_sub_categories",
			data: {
				main_category: $(this).val(),
				sub_categories_id: 'classified_sub_category_id',
				name: 'classified[sub_category_id]'
			}
		});
	});

	$('#search_main_category_id_eq').change(function(){
		$.ajax({
			url: "/classifieds/change_sub_categories",
			data: {
				main_category: $(this).val(),
				sub_categories_id: 'search_sub_category_id_eq',
				name: 'search[sub_category_id_eq]'
			}
		});
	});
});

function getUrlVars() {
  var vars = {};
  var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
      vars[key] = value;
  });
  return vars;
}
