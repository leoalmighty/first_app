var setContentHeight = function () {
  var windowHeight = $(window).height();
  $('.content').css('height', windowHeight - 275 + 'px');
};

jQuery(function () {
  setContentHeight();
  $(window).resize(setContentHeight);
});