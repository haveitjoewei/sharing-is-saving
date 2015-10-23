var sis = (function() {
	var apiUrl = 'https://sis-backend.herokuapp.com/api/v1/';

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

	var insertListing = function(listing, beginning) {
		var newElem = $(listingTemplateHtml);
		newElem.attr('id', listing.id);
		newElem.find('.title').text(listing.title);
		newElem.find('.posted_by').text(listing.user_id);
		newElem.find('.description').text(listing.description);
		newElem.find('.price').text(listing.price);
		newElem.find('.deposit').text(listing.security_deposit);
		if (beginning) {
			listings.prepend(newElem);
		} else {
			listings.append(newElem);
		}
	}

	var displayListings = function() {
		var onSuccess = function(data) {
			console.error('displayListings success')
			for (var i = 0; i < data.post.length; i++) {
				insertListing(data.post[i], false);
			}
		};
		var onFailure = function(data) {
			console.error('displayListings failed');
		};
		makeGetRequest('posts', onSuccess, onFailure);
	};

	var start = function() {
		listings = $(".listings");

		listingTemplateHtml = $(".listings .listing")[0].outerHTML;
		listings.html('');

		displayListings();
	}

	return {
		start: start,
		displayListings: displayListings
	};

})();
