function createLinks() {
  $('.mdl-card').each(function(index) {
    $(this).click(function () {
      var link = $(this).data('link');
      window.open(link, '_blank');
    });
  });
}

function setAction(type) {
  $('form.trackers').attr("action", "/" + type + "_trackers/");
}

function setCardHeight() {
  $('.mdl-card').each(function(index) {
    var height = $(this).width();
    $(this).height(height);
  });
}
