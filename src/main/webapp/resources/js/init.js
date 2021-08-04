



// when document loaded
$(document).ready(function() {
  $('.sidenav').sidenav();
  $('.collapsible').collapsible();
  $('select').formSelect();
  $('.parallax').parallax();
  $('.modal').modal({
    onCloseStart() {
      console.log("닫힘")
      $('#supreme-container').removeClass('blur');
    }
  });
});
