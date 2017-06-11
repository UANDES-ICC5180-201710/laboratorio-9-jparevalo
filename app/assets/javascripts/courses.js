// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
function toggleInterest(clicked_course_id) {
    $button = $('#'+clicked_course_id);
    $interestedPeople = $('#interested-people-'+clicked_course_id);
    if($button.hasClass('isActive')){

        $button.addClass('notActive');
        $button.removeClass('isActive');
        $url = 'remove_interest';
    } else {

        $button.addClass('isActive');
        $button.removeClass('notActive');
        $url = 'add_interest';
    }
    $button.blur();

    $.ajax({
      type: "GET",
      dataType: "json",
      url: $url,
      data: {
          course_id: clicked_course_id// < note use of 'this' here
      },
      success: function(json) {
          $interestedPeople.html("Interesados: " + json.interestedPeople);

      },
      error: function(json) {
          $interestedPeople.html("Interesados: " + json.interestedPeople);
      }
  });
}
$(document).ready(function() {
  var $addPersonForm = $('#addPersonAndEnrollment form');
  var $url = 'add_interest';

  $addPersonForm.on('ajax:success', function(e, data, status, xhr)  {
    var $newHtml = $(data);
    $addPersonForm.html($newHtml.find('form#new_person').html());
  }).on('ajax:error', function(e, xhr, status, error) {
    alert(error);
  });

});
