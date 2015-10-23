var Share = (function() {
	var apiUrl = "http://sis-backend.herokuapp.com";

	var create;

	var makeGetRequest = function(url, onSuccess, onFailure) {
       $.ajax({
           type: 'GET',
           url: apiUrl + url,
           dataType: "json",
           success: onSuccess,
           error: onFailure
       });
   };

    /**
     * HTTP POST request
     * @param  {string}   url       URL path, e.g. "/api/smiles"
     * @param  {Object}   data      JSON data to send in request body
     * @param  {function} onSuccess   callback method to execute upon request success (200 status)
     * @param  {function} onFailure   callback method to execute upon request failure (non-200 status)
     * @return {None}
     */
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

    var attachCreateHandler = function(e) {
    	create.on('click', '.submit-input', function(e) {
    		e.preventDefault();

    		var post = {};
    		post["title"] = create.find('.title-input').val();
    		post["latitude"] = parseInt(create.find('.latitude-input').val());
    		post["longitude"] = parseInt(create.find('.longitude-input').val());
    		post["description"] = create.find('.description-input').val();
    		post["price"] = parseInt(create.find('.price-input').val());
    		post["deposit"] = parseInt(create.find('.deposit-input').val());
    		post["status"] = parseInt(create.find('.status-input').val());
    		post["user"] = create.find('.user-input').val();

    		post = {
    			"post": {
    				"title": "example post 50",
    				"latitude": "123.456",
    				"longitude": 2345.67,
    				"description": "example description",
    				"price": 12.34,
    				"security_deposit": 56.89,
    				"user": 1,
    				"status": 1
    			}
    		};

    		console.log(post);

    		var onSuccess = function(data) {
    			// console.log(data);
    		};

    		var onFailure = function() {
    			console.error('create post failed');
    		};

    		makePostRequest("/api/v1/posts", post, onSuccess, onFailure);
    	});
    };

	var displayPosts = function() {
	};

	var start = function() {
		create = $(".create")

		attachCreateHandler();
	};

	return {
		start: start
	};
})();
