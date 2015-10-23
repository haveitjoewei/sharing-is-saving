var User = (function() {
	var apiUrl = "http://sis-backend.herokuapp.com";

	var signup;
    var login;

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

    var attachSignupHandler = function(e){
        signup.on('click', '#signup_submit', function(e) {
            e.preventDefault();

            var user = {};
            user["email"] = signup.find('#email').val();
            user["password"] = signup.find('#password').val();
            user["password_confirmation"] = signup.find('#password_confirmation').val();
            user["first_name"] = signup.find('#first_name').val();
            user["last_name"] = signup.find('#last_name').val();
            user["date_of_birth"] = signup.find('#date_of_birth').val();
            user["latitude"] = signup.find('#latitude').val();
            user["longitude"] = signup.find('#longitude').val();

            user = {"user": user};

            var onSuccess = function(data) {
                console.log(data);
            };

            var onFailure = function() {
                console.error('create user failed');
            };

            makePostRequest("/api/v1/users", user, onSuccess, onFailure);
            signup.hide();
        });
    };

    var attachLoginHandler = function(e) {
        login.on('click', '#login_submit', function(e) {
            e.preventDefault();

            var user = {};
            user["email"] = login.find('#email').val();
            user["password"] = login.find('#password').val();

            var onSuccess = function(data) {
                console.log(data);
            };

            var onFailure = function() {
                console.error('login user failed');
            }; 

            makePostRequest("/api/v1/users/sign_in", user, onSuccess, onFailure);
        });
    };

	var start = function() {
		signup = $("#signup_dialog");
        login = $("#login_dialog");

		attachSignupHandler();
        attachLoginHandler();
	};

	return {
		start: start
	};
})();