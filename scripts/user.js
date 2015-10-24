var User = (function() {
	var apiUrl = "https://sis-backend.herokuapp.com/api/v1/";

	var signup;
    var login;
    var logout;
    var signup_button;
    var login_button;
    var user_label;

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
               "Content-Type": "application/json; charset=utf-8"   
            },
            url: apiUrl + url,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json",
            success: onSuccess,
            error: onFailure
        });
    };

    var makeDeleteRequest = function(url, onSuccess, onFailure) {
        $.ajax({
            type: 'DELETE',
            headers: {          
               "X-API-EMAIL" : readCookie('email'),
               "X-API-TOKEN" : readCookie('auth_token')
            },
            url: apiUrl + url,
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
            user["latitude"] = 1 //signup.find('#latitude').val();
            user["longitude"] = 1 //signup.find('#longitude').val();

            user = {"user": user};

            var onSuccess = function(data) {
                console.log(data);

                var login_user = {};

                login_user["email"] = data.user.email;
                login_user["password"] = signup.find('#password').val();
                console.log(login_user);

                var onSuccess = function(data) {
                    console.log(data);
                    token = data.user.auth_token;
                    email = data.user.email;
                    createCookie('auth_token', token, 7);
                    createCookie('email', email, 7);
                    var x = readCookie('auth_token');
                    var y = readCookie('email');
                    console.log("cookie: " + x);
                    console.log("cookie: " + y);
                    user_label.show();
                    user_label.text(data.user.email);
                };

                var onFailure = function(data) {
                    console.log(data);
                    console.error('login user failed');
                }; 

                makePostRequest("users/sign_in", login_user, onSuccess, onFailure);
                signup_button.hide();
                login_button.hide();
                logout.show();
                signup.hide();
            };

            var onFailure = function(data) {
                console.error('create user failed');
                console.log(data);
            };

            makePostRequest("users", user, onSuccess, onFailure);
        });
    };

    var attachLoginHandler = function(e) {
        login.on('click', '#login_submit', function(e) {
            e.preventDefault();

            var user = {};

            user["email"] = login.find('#loginemail').val();
            user["password"] = login.find('#loginpassword').val();
            
            var onSuccess = function(data) {
                console.log(data);
                token = data.user.auth_token;
                email = data.user.email;
                createCookie('auth_token', token, 7);
                createCookie('email', email, 7);
                var x = readCookie('auth_token');
                var y = readCookie('email');
                console.log("cookie: " + x);
                console.log("cookie: " + y);
                user_label.show();
                user_label.text(data.user.email);
                signup_button.hide();
                login_button.hide();
                logout.show();
            };

            var onFailure = function(data) {
                console.log(data);
                console.error('login user failed');
            }; 

            makePostRequest("users/sign_in", user, onSuccess, onFailure);
        });
    };

    var attachLogoutHandler = function() {
        logout.on('click', function(e){
            e.preventDefault();

            var onSuccess = function(data) {
                console.log(data);
                deleteCookie('auth_token');
                deleteCookie('email');
                // var x = document.cookie;
                // console.log("cookie: " + x);
                signup_button.show();
                login_button.show();
                logout.hide();
                user_label.hide();
            };

            var onFailure = function(data) {
                console.log(data);
                console.log("damn");
            };

            makeDeleteRequest("users/sign_out", onSuccess, onFailure);
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

	var start = function() {
		signup = $("#signup_dialog");
        login = $("#login_dialog");
        logout = $("#logout");
        signup_button = $("#signup");
        login_button = $("#login");
        user_label = $("#user");

		attachSignupHandler();
        attachLoginHandler();
        attachLogoutHandler();
	};

	return {
		start: start
	};
})();