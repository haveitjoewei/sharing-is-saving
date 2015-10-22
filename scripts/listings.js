var sis = (function() {
	var apiUrl = '';

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
		newElem.find('.posted_by').text(listing.user.first_name);
		newElem.find('.description').text(listing.description);
		newElem.find('.price').text(listing.price);
		newElem.find('.deposit').text(listing.security_deposit);
		if (beginning) {
			smiles.prepend(newElem);
		} else {
			smiles.append(newElem);
		}
	}

	var displayListings = function() {
		var onSuccess = function(data) {
			for (var i = 0; i < data.listings.length; i++) {
				insertListing(data.listings[i], false);
			}
		};
		var onFailure = function(data) {
			console.error('displayLisings failed');
		};
		makeGetRequest('/api/v1/posts', onSuccess, onFailure);
	};

	var start = function() {
		listings = $(".listings");

		listingTemplateHtml = $(".listings .listing")[0].outerHTML;
		listings.html('');

		displayListings();
	}

	return {
		start: start
	};
})();
