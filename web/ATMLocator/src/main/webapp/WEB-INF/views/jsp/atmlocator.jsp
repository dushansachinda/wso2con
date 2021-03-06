<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<spring:url value="/resources/core/css/hello.js" var="coreJs" />
<spring:url value="/resources/core/css/bootstrap.min.js"
	var="bootstrapJs" />


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title>Google Maps Multiple Markers</title>
<script src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyBiaH6GjsZHkhbk9xG_LlEYkZHdBZFp1ek"></script>
<spring:url value="/resources/core/css/hello.css" var="coreCss" />
<spring:url value="/resources/core/css/bootstrap.min.css"
	var="bootstrapCss" />
<link href="${bootstrapCss}" rel="stylesheet" />
<link href="${coreCss}" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/resources/core/js/googlemap.js"></script>
</head>
<body>

	<spring:url value="/resources/core/css/hello.js" var="coreJs" />
	<spring:url value="/resources/core/css/bootstrap.min.js"
		var="bootstrapJs" />

	<script src="${coreJs}"></script>
	<script src="${bootstrapJs}"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>


	<div class="jumbotron">
		<div class="container">
			<h1>${title}</h1>
			<p>
				<c:if test="${empty name}">
			       Welcome To The XYZ ATM Locator Service! 
		        </c:if>
			</p>
		</div>
	</div>

	<div class="container">
	    <div class="row">
	       <p>
			Search For ATM:<spring:url value="/findatm" var="userActionUrl" />
			
			<table>
				<form:form method="post" modelAttribute="findATMform"
					action="${userActionUrl}">
					<td>Enter zip code:</td>
					<td><form:input path="zipcode" type="text" /></td>
					<td>longitude:</td>
					<td><form:input path="lag" type="text" /></td>
					<td>latitude:</td>
					<td><form:input path="lat" type="text" /></td>
					<td><input type="submit" value="Submit" /></td>
				</form:form>
			</table>
			</p>
	    </div>
		<div class="row">
			<div class="col-md-4">
				<p>
				<c:if test="${not empty error}">
			       <b>${error}</b>
		        </c:if>
				<div style="overflow-x: auto;">
					<div id="datalist"></div>
				</div>
				</p>
			</div>
			<div class="col-md-4">
				<p>
				<div id="map" style="width: 400px; height: 400px;"></div>
				</p>
			</div>
		</div>
	</div>



	<script type="text/javascript">
		
	   function initialize() {
		    var map = new google.maps.Map(document.getElementById('map'), {
				zoom : 12,
				center : new google.maps.LatLng(37.7749, -122.4194),
				mapTypeId : google.maps.MapTypeId.ROADMAP
			});
		    
		    var infowindow = new google.maps.InfoWindow();
			var json = ${mapResuls};
			var marker, i;
			var test = 1;
			for (i = 0; i < json.length; i++) {
				var data = json[i];
				marker = new google.maps.Marker({
					position : new google.maps.LatLng(data.lat, data.lng),
					map : map,
					title : data.title
				});
				var description = data.description;
				google.maps.event.addListener(marker, 'click',
						(function(marker, i) {
							return function() {
								infowindow.setContent(json[i].description);
								infowindow.open(map, marker);
							}
						})(marker, i));
			}

			$(document)
					.ready(
							function() {
								var obj = ${mapResuls};
								var table = '<table border="1"><thead><th width="40%">Address</th><th>Description</th></thead><tbody>';
								//var obj = $.parseJSON(data);
								$.each(obj, function() {
									table += '<tr><td>' + this['title']
											+ '</td><td>' + this['description']
											+ '</td></tr>';
								});
								table += '</tbody></table>';
								document.getElementById("datalist").innerHTML = table;
							});
			
			
			
	    }
	
		
         google.maps.event.addDomListener(window, "load", initialize);
		
	</script>
</body>
</html>