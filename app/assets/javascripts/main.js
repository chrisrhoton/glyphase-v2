(function($){

	window.PROJECT_NAME = {};

	var SHORT_NAME = window.PROJECT_NAME;

	SHORT_NAME.init = function(){
		SHORT_NAME.setElements();
		SHORT_NAME.basics();
	}

	SHORT_NAME.setElements = function(){
		SHORT_NAME.elems = {};
	}
	
	SHORT_NAME.basics = function(){

	}

	$(window).load(function() {

	});


	$(document).ready(function(){
		
		SHORT_NAME.init();

		$('.input-textbox').autosize();    

		$('.nav-brand').click(function() {
			window.location.href= "/";
			console.log("clicked");
		});

		$('.glyphComments-adding').hide();

		$('#addComment').click(function() {
			$("body").addClass("is-adding-comment");
			$('#addComment').hide();
			$('.glyphComments-adding').fadeIn();
		});

		$('#cancelComment').click(function() {
			$("body").removeClass("is-adding-comment");
			$('#addComment').fadeIn();
			$('.glyphComments-adding').hide();
		});

		$("#like").click(function() {
			$("#like").toggleClass("is-liked");
		});

		$(".nav-mobile-icon").click(function() {
			console.log("nav-mobile clicked!")
			$(".nav-mobile").toggleClass("is-selected");
		});

	});//close document ready

})(jQuery)