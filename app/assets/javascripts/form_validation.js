$(document).on('ready page:load', function() {
   $("#new_review").on("submit", function(e) {
     remove_previous();
     validateContent(e, "review");
   })
   
   $("#new_comment").on("submit", function(e) {
     remove_previous()
     validateContent(e, "comment");
   })
   
   $("#new_user").on("submit", function(e) {
     remove_previous()
     validateSignup(e, "user");
   }) 
   
})

// Helper functions
function remove_previous() {
  if ($("#error_explanation").length) { $("#error_explanation").remove(); }
}

function isEmpty(s) {
  return s.length == 0;
}

function showErrors(errors, type) {
  $("#new_" + type).prepend("<div id='error_explanation'></div>");
  $("#error_explanation").prepend("<div class='alert alert-danger'> This form contains " +
  errors.length + " errors" + "</div>");
  
  $("#error_explanation").append("<ul></ul>");
  
  for (var i in errors) {
    $("#error_explanation > ul").append("<li>" + errors[i] + "</li>");
  }
}

// Input checkers
function ratingError(rating) {
  if (rating >= 1 && rating <= 5) {
    return false;
  }
  return "A rating must be entered";
}

function contentError(content) {
  if (isEmpty(content)) {
    return "Your review cannot be blank";
  }
  else if (content.length < 10) {
    return "Your review must be at least 10 characters";
  }
  return false;
}

function usernameError(username) {
  if (isEmpty(username)) {return "Username cannot be blank"}
  else if (username.length < 3) {return "Username is too short (minimum 3 characters)";}
  else if (username.length > 30) {return "Username is too long (max 30 characters)";}
  else {return false;}
}

function emailError(email) {
  if (isEmpty(email)) {return "Email cannot be blank";}
  else if (email.length > 255) {return "Email is too long (max 255 characters)";}
  else if (!(/^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/).test(email)) {return "Invalid email address";}
  else {return false;}
}

function passError(password) {
  if (isEmpty(password)) {return "Password cannot be blank";}
  else if (password.length < 6) {return "Password is too short (minimum 6 characters)";}
  else {return false;}
}

function verifyError(password, verify) {
  if (password != verify) {return "Password confirmation does not match password";}
  else {return false;}
}

// Signup validation
function validateSignup(e, type) {
  var errors = [];
  
  var username = $("#user_username").val();
  var email = $("#user_email").val();
  var password = $("input[name='user[password]'").val();
  var pass_verify = $("input[name='user[password_confirmation]'").val();
  
  
  usernameErrorExist = usernameError(username);
  emailErrorExist = emailError(email);
  passErrorExist = passError(password);  
  verifyErrorExist = verifyError(pass_verify);
    
  if (usernameErrorExist) {errors.push(usernameErrorExist);}
  if (emailErrorExist) {errors.push(emailErrorExist);}
  if (passErrorExist) {errors.push(passErrorExist);}
  if (verifyErrorExist) {errors.push(verifyErrorExist);}

  if (errors.length != 0) {
    e.preventDefault();
    showErrors(errors, type);
  }
}

// Review and comment validation
function validateContent(e, type) {
  var errors = [];

  var rating = $("input:radio[name ='" + type + "[rating]']:checked").val();
  var content = $("#" + type + "_content").val();
    
  var ratingErrorExist = ratingError(rating);
  var contentErrorExist = contentError(content);
    
  if (ratingErrorExist) { errors.push(ratingErrorExist); }
  if (contentErrorExist) { errors.push(contentErrorExist); }
  
  if (errors.length != 0) {
    e.preventDefault();
    showErrors(errors, type);
  }
}
