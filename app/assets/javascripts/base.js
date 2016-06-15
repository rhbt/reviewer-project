$(document).ready(function() {
  $(document).on('mouseenter', ".star-empty", function() { 
    var pos = parseInt($(this).attr("id")[0]);
    
      for (i = pos; i > 0 ; i--) {
        $("#"+i.toString()+"-star").attr("class", "star-full");
      }
   
  }).on('mouseleave', ".star-full", function() { 
    
    for (i = 0; i < 6 ; i++) {
      $("#"+i.toString()+"-star").attr("class", "star-empty");
    }
       
  }).on("click", ".star-full, .star-red, .star-end", function() {
    
    var pos = parseInt($(this).attr("id")[0]);
      for (i = pos; i > 0 ; i--) {
        $("#"+i.toString()+"-star").attr("class", "star-red");
      }
      
      for (i = pos + 1 ; i < 6 ; i++) {
        $("#"+i.toString()+"-star").attr("class", "star-end");
      }
  });
});
