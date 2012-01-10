$(document).ready(function(){
	var first_name = $("span.given-name").html()
	var last_name  = $("span.family-name").html()
	var educations = $("#profile-education").find("div.position")
	var data = {
	  "wid"        : "1",
		"first_name" : first_name ? first_name : "",
		"last_name"	 : last_name  ? last_name  : "",
		"education"	 : [],
		"experience" : [],
		"search"		 : window.location.search
	};
	$.each(educations,function(index,value){
		var school = $(value).find("h3 a").html()
		var start  = $(value).find("p.period abbr.dtstart").attr("title")
		var end  	 = $(value).find("p.period abbr.dtend").attr("title")
		var degree = $(value).find("h4 span.degree").html()
		var major  = $(value).find("h4 span.major a").html()
		var text   = $(value).find("p.details-education").html()
		var ed = {
			"school" : school ? school : "",
			"start"  : start  ? start  : "",
			"end"		 : end 	  ? end 	 : "",
			"degree" : degree ? degree : "",
			"major"	 : major  ? major  : "",
			"text"   : text   ? text 	 : ""
		}
		data["education"].push(ed)
	})
	var experiences = $("#profile-experience").find("div.position")
	$.each(experiences,function(index,value){
		var position = $(value).find("h3 a").html()
		var start = $(value).find("p.period abbr.dtstart").attr("title")
		var end = $(value).find("p.period abbr.dtend").attr("title")
		var company = $(value).find("h4 a span").html()
		if(!company) {
			company = $(value).find("h4 a").html()
		}
		var text = $(value).find("p.description").html()
		var job = {
			"position" : position ? position : "",
			"start"		 : start 	  ? start 	 : "",
			"end"			 : end 		  ? end 		 : "",
			"company"	 : company  ? company  : "",
			"text"		 : text 		? text 		 : ""
		}
		data["experience"].push(job)
	})
	console.log(data)
	$.ajax({
		type: 'POST',
		url: "http://young-beach-2959.herokuapp.com/store/create",
		data: data,
		crossDomain: true,
		success: function(data,textStatus,jqXHR) {
		},
		error: function(jaXHR,textStatus, errorThrown) {
		},
		dataType: "json"
	});
})