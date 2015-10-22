$(document).ready(function(){
  $("#signup_dialog").hide();
  $("#login_dialog").hide();
  $("#darken").hide();

  $("#signup").click(function(){
    $("#signup_dialog").show();
    $("#darken").show();
  });

  $("#login").click(function(){
    $("#login_dialog").show()
    $("#darken").show();
  });

  $("#darken").click(function(){
    $("#signup_dialog").hide();
    $("#login_dialog").hide();
    $("#darken").hide();
  })

  $("#signup_submit").click(function(){
    $("#signup_dialog").hide();
    $("#darken").hide();
  })
});
