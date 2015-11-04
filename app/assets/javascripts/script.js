$(document).ready(function(){
  $("#signup_dialog").hide();
  $("#login_dialog").hide();
  $("#darken").hide();
  $("#logout").hide();
  $("#user").hide();

  $("#signup").click(function(){
    $("#signup_dialog").fadeIn(100);
    $("#darken").fadeIn(100);
  });

  $("#login").click(function(){
    $("#login_dialog").fadeIn(100);
    $("#darken").fadeIn(100);
  });

  $("#darken").click(function(){
    $("#signup_dialog").fadeOut(100);
    $("#login_dialog").fadeOut(100);
    $("#darken").fadeOut(100);
  });

  $("#signup_submit").click(function(){
    $("#signup_dialog").fadeOut(100);
    $("#darken").fadeOut(100);
  });

  $("#login_submit").click(function(){
    $("#login_dialog").fadeOut(100);
    $("#darken").fadeOut(100);
  });

});
