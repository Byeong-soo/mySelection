



// when document loaded
$(document).ready(function() {
  $('.sidenav').sidenav();
  $('.collapsible').collapsible();
  $('select').formSelect();
  $('.parallax').parallax();
  //
  $('.tooltipped').tooltip({
    exitDelay: 0,
    enterDelay: 0,
    position: 'right'
  });
  $('.dropdown-trigger').dropdown({
    inDuration: 300,
    outDuration: 225,
    constrainWidth: false,
    hover: false,
    // belowOrigin: false,
    alignment: 'left',
    // stopPropagation: false
  });



  $('.modal').modal({
    onCloseStart() {
      console.log("닫힘")
      $('div[name=supreme-container]').removeClass('blur');
    }
  });


  $('.datepicker').datepicker({

    format: 'yyyy-mm-dd',
    setDefaultDate: false,
    defaultDate: new Date(1993,3,9),
    fistDay: 0,
    autoClose: false,
    minDate: new Date(1960, 1, 1),
    maxDate: new Date(),
    yearRange: [1960, new Date().getFullYear()],
    showMonthAfterYear: true,

    i18n: {
      months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
      monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11", "12월"],
      weekdays: ["일요일","월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
      weekdaysShort: ["일","월", "화", "수", "목", "금", "토"],
      weekdaysAbbrev: ["일","월", "화", "수", "목", "금", "토"]
    }
  });

// ajax 에러처리 나중에 수정해둘것~
  $.ajaxSetup({
    error: function(jqXHR, exception) {
      if (jqXHR.status === 0) {
        alert('Not connect.\n Verify Network.');
      }
      else if (jqXHR.status == 400) {
        alert('Server understood the request, but request content was invalid. [400]');
      }
      else if (jqXHR.status == 401) {
        alert('Unauthorized access. [401]');
      }
      else if (jqXHR.status == 403) {
        alert('Forbidden resource can not be accessed. [403]');
      }
      else if (jqXHR.status == 404) {
        alert('Requested page not found. [404]');
      }
      else if (jqXHR.status == 500) {
        alert('Internal server error. [500]');
      }
      else if (jqXHR.status == 503) {
        alert('Service unavailable. [503]');
      }
      else if (exception === 'parsererror') {
        alert('Requested JSON parse failed. [Failed]');
      }
      else if (exception === 'timeout') {
        alert('Time out error. [Timeout]');
      }
      else if (exception === 'abort') {
        alert('Ajax request aborted. [Aborted]');
      }
      else {
        alert('Uncaught Error.n' + jqXHR.responseText);
      }
    }
  });




}); // end

