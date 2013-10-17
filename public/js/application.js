$(document).ready(function() {
  


  $("a#create_post").click(function(event){
    event.preventDefault();

   var $ourLink = $(this);
   var url = $ourLink.attr("href");

    $.get(url, function(response) {
      // console.log(response);
      console.log($ourLink);
      $ourLink.after(response);
    });
  });
  $(document).on("submit", "form#new_post", function(event){
    event.preventDefault();
    console.log(this);
    var $ourForm = $(this);
    var url = $ourForm.attr('action')
    var data = $ourForm.serialize()
    $.post(url, data, function(response) {
      $('.all_posts').html(response);
    })
  })



});
