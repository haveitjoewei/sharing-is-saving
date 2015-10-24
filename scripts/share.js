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
            headers: {
               Accept : "application/json; charset=utf-8",
               "Content-Type": "application/json; charset=utf-8",
               "X-API-EMAIL" : readCookie('email'),
               "X-API-TOKEN" : readCookie('auth_token')
            },
            url: apiUrl + url,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json",
            success: onSuccess,
            error: onFailure
        });
    };

    function createCookie(name,value,days) {
        if (days) {
            var date = new Date();
            date.setTime(date.getTime()+(days*24*60*60*1000));
            var expires = "; expires="+date.toGMTString();
        }
        else var expires = "";
        document.cookie = name+"="+value+expires+"; path=/";
    };

    function readCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for(var i=0;i < ca.length;i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1,c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
        }
        return null;
    };

    function deleteCookie(name) {
        document.cookie = name + '=;expires=Thu, 01 Jan 1970 00:00:01 GMT;';
    };


    var attachCreateHandler = function(e) {
    	create.on('click', '.submit-input', function(e) {
    		e.preventDefault();

    		var post = {};
    		post["title"] = create.find('.title-input').val();
    		post["latitude"] = 1 //parseInt(create.find('.latitude-input').val());
    		post["longitude"] = 1 //parseInt(create.find('.longitude-input').val());
    		post["description"] = create.find('.description-input').val();
    		post["price"] = parseInt(create.find('.price-input').val());
    		post["security_deposit"] = parseInt(create.find('.deposit-input').val());
    		post["status"] = 1 //parseInt(create.find('.status-input').val());
    		post["user"] = 1 //create.find('.user-input').val();

            post = {"post": post};

            // console.log(post);
            // var x = document.cookie;
            // console.log("cookie" + x);

    		var onSuccess = function(data) {
    			console.log(data);
                window.location.href = 'listings.html';
    		};

    		var onFailure = function() {
    			console.error('create post failed');
    		};

    		makePostRequest("/api/v1/posts", post, onSuccess, onFailure);
    	});
    };


	var start = function() {
		create = $(".create")

		attachCreateHandler();
	};

	return {
		start: start
	};
})();
