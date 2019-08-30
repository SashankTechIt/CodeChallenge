<!DOCTYPE html>
<html>
<head>
<script type = "text/javascript" src = "https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type = "text/javascript" src = "https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js"></script>
<style>
.div-conatiner {
  background-color: orange;
  color: black;
  margin: 20px;
  padding: 20px;
} 
.error {
  color: red;
}
</style>
<script>
$(document).ready(function(){
	$( "#submitBt" ).click(function( event ) {
		var city = $("#city").val();
		if(!city) {
	    	$("#error").text("City field is empty");
	    }
		else if(!city.match("^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$")) {
			$("#error").text("Invalid city name:"+city);
		}
		else {
			var data = {};
			data["city"] = city;
			$.ajax ({
			    url: 'weather',
			    headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			    type: "POST",
			    data: JSON.stringify(data),
			    dataType: "json",
			    contentType: "application/json",
			    success: function(data){
			    	var content = JSON.parse(JSON.stringify(data));
				    $( "#cityname" ).empty().append( "City: "+content.name );
				    $( "#main" ).empty().append( "Condition: "+content.weather[0].main );
				    $( "#temp" ).empty().append( "Temperature: "+content.main.temp);
				    $( "#humidity" ).empty().append( "Humidity: "+content.main.humidity);
				    $( "#pressure" ).empty().append( "Pressure: "+content.main.pressure);
				    $("#resultsDiv").effect( "bounce", {times:3}, 300 );
			    }
			});	
		}
	});
});
</script>
</head>
<body>
	<h2>Weather Information Portal</h2>
	<form method="post" id="weatherForm">
	City: <input type="text" name="city" id="city" /> 
	      <input type="button" id="submitBt" value="Submit" />
	</form>
	<p id="error" class="error">
	<p>
	<h3>Weather Information:</h3>
	<div class="div-conatiner" id="resultsDiv">
	  <p id="cityname"></p>
      <p id="main"></p>
      <p id="temp"></p>
      <p id="humidity"></p>
      <p id="pressure"></p>
     </div>
</body>
</html>