$( document ).ready(function() {
	console.log( "header loaded" );

	signup = $("#signup_dialog");
	login = $("#login_dialog");
	logout = $("#logout");
	signup_button = $("#signup");
	login_button = $("#login");
	user_label = $("#user");

	var auth_cookie = readCookie('auth_token');
	var email_cookie = readCookie('email');

	if (auth_cookie == null) {
		user_label.hide();
		logout.hide();
		signup_button.show();
		login_button.show();
	} else {
		login.hide();
		login_button.hide();
		signup_button.hide();
		signup.hide();
		user_label.show();
		logout.show();
		user_label.text(email_cookie);
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
});