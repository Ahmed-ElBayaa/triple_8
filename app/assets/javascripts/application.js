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
	$('#classified_main_category_id').change(function(){
		$.ajax({
			url: "/classifieds/change_sub_categories",
			data: {main_category: $(this).val()}
		});
	});
});