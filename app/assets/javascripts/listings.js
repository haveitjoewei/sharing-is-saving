var sis = (function() {
	var apiUrl = 'https://sharingissaving.herokuapp.com/api/v1/';
	// var apiUrl = 'localhost:3000/api/v1/'

	var listings;
	var listingTemplateHtml;

	var makeGetRequest = function(url, onSuccess, onFailure) {
		$.ajax({
			type: 'GET',
			url: apiUrl + url,
			dataType: "json",
			success: onSuccess,
			error: onFailure
		});
	};

	var makePostRequest = function(url, data, onSuccess, onFailure) {
		$.ajax({
			type: 'POST',
			url: apiUrl + url,
			data: JSON.stringify(data),
			contentType: "application/json",
			dataType: "json",
			success: onSuccess,
			error: onFailure
		});
	};

	var insertListing = function(listing, beginning, index) {
		var newElem = $(listingTemplateHtml);
		newElem.attr('id', listing.id);
		newElem.find('.title').text(index.toString() + '. ' + listing.title);
		newElem.find('.posted_by').text('Posted by ' + listing.user_id);
		newElem.find('.description').text(listing.description);
		newElem.find('.price').text('$' + listing.price + ' per day');
		newElem.find('.deposit').text('$' + listing.security_deposit + ' security deposit');
		if (beginning) {
			listings.prepend(newElem);
		} else {
			listings.append(newElem);
		}
		new google.maps.Marker({
			position: {lat: listing.latitude, lng: listing.longitude},
			map: map,
			label: index.toString()
		});
	}

	var displayListings = function(coords) {
		var onSuccess = function(data) {
			for (var i = 0; i < data.post.length; i++) {
				insertListing(data.post[i], false, i+1);
			}
		};
		var onFailure = function(data) {
			console.error('displayListings failed');
		};
		makeGetRequest('posts?center=' + coords.latitude + ',' + coords.longitude + '&radius=10', onSuccess, onFailure);
	};

	var getLocation = function() {
	    if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(showPosition);
	    } else { 
	        console.log("Geolocation is not supported by this browser.");
	    }
	}

	var showPosition = function(position) {
		var pos = {
			lat: position.coords.latitude,
			lng: position.coords.longitude
		};

		map = new google.maps.Map(document.getElementById('map'), {
			center: pos,
			minZoom: 11,
			maxZoom: 15,
			zoom: 13,
			disableDefaultUI: true,
			// disableDoubleClickZoom: true,
			scrollwheel: false
		});

		displayListings(position.coords)
	}

	var start = function() {
		var map;

		getLocation();

		listings = $(".listings");

		listingTemplateHtml = $(".listings .listing")[0].outerHTML;
		listings.html('');
	}

	return {
		start: start,
		displayListings: displayListings
	};

})();
