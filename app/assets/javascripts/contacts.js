$(function(){

  if ($("#download-csv").length) {
    $("#download-csv").click(function(){
      $('#download-csv').after("<div class='text-center' id='notify-banner'><br><div class='alert alert-success' role='alert'>" +
                                "<div class='d-flex align-items-center'><strong>Downloading layout...</strong>" +
                                "<div class='spinner-border ml-auto' role='status' aria-hidden='true'></div></div></div>");
      setTimeout(function(){
        $("#notify-banner").remove();
        $(".hidden_form").show();
      }, 2000)
    })
  }
  
})
