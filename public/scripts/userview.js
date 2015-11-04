var userview = (function() {
	var apiUrl = 'https://sharingissaving.herokuapp.com/api/v1/';
	// var apiUrl = 'localhost:3000/api/v1/'

	var userinfo;
	var userinfoTemplateHtml;

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
	}

	var displayListings = function(coords) {
		var query = window.location.search;
		if (uery.substring(0, 1) == '?') {
			query = query.substring(1);
		};
		var data = query.split(',');
		for (i = 0; (i < data.length); i++) {
			data[i] = unescape(data[i]);
		};
		var user = data[0]

		var onSuccess = function(data) {
			for (var i = 0; i < data.post.length; i++) {
				insertListing(data.post[i], false, i+1);
			}
		};
		var onFailure = function(data) {
			console.error('displayListings failed');
		};
		makeGetRequest('posts?user=' + user, onSuccess, onFailure);
	};

	var start = function() {
		listings = $(".user_listings");
		userinfo = $(".user_info");

		listingTemplateHtml = $(".user_listings .listing")[0].outerHTML;
		userinfoTemplateHtml = $(".user_info")[0].outerHTML;

		listings.html('');
		userinfo.html('');
	}

	return {
		start: start,
		displayListings: displayListings
	};

})();
