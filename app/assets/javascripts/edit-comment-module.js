var editCommentModule = (function editCommentHelpers() {
  function getCommentID(cssID) {
    return cssID.slice(cssID.lastIndexOf("-")+1);
  }

  function edit_errors(content) {
    var errors = [];
    if (content.length == 0) {errors.push("Your review cannot be blank");} 
    else if (content.length < 10) {errors.push("Your review must be at least 10 characters");}
    return errors;
  }
  
  return {
    getCommentID: getCommentID,
    edit_errors: edit_errors
  }
})();

