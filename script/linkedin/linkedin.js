$(document).ready(function(){
	var educations = $("#profile-education").find("div.position")
	var data = {
		"education":[],
		"experience":[],
		"search":window.location.search
	};
	$.each(educations,function(index,value){
		var ed = [
			$(value).find("h3 a").html(), // school
			$(value).find("p.period abbr.dtstart").attr("title"), // start
			$(value).find("p.period abbr.dtend").attr("title"), // end
			$(value).find("h4 span.degree").html(), // degree
			$(value).find("h4 span.major a").html(), // major	
			$(value).find("p.details-education").html() // text
		]
		data["education"].push(ed)
	})
	var experiences = $("#profile-experience").find("div.position")
	$.each(experiences,function(index,value){
		var company = $(value).find("h4 a span").html()
		if(!company) {
			company = $(value).find("h4 a").html()
		}
		var job = [
			$(value).find("h3 a").html(), // position
			$(value).find("p.period abbr.dtstart").attr("title"), // start
			$(value).find("p.period abbr.dtend").attr("title"), // end
			company,
			$(value).find("p.description").html() // text
		]
		data["experience"].push(job)
	})
	$.ajax({
		type: 'POST',
		url: "http://young-beach-2959.herokuapp.com/store/create",
		data: {
			"eduction":data["education"],
			"experience":data["experience"],
			"search":data["search"]
		},
		crossDomain: true,
		success: function(data,textStatus,jqXHR) {
		},
		error: function(jaXHR,textStatus, errorThrown) {
		},
		dataType: "json"
	});
})