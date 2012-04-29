//global
var window_size;
var pages;
var sections = [];

$(function() {
  window_size = $(window).height();
  pages = $('.page');
  pages.height(window_size);
  pages.delay(200).fadeIn(400, function() {
    $(window).resize(function() {
      window_size = $(window).height();
      pages.height(window_size);
    });
    $(window).scroll(checkIndex);
  });
  
  $('.anchored').click(function(me) {
    me.preventDefault();
    $('#modal').fadeOut(150);
    goToByScroll($(this).attr('href'));
  });

  $('.thumb').hover(function() {
    $(this).children('.play-button-wrapper').stop(true,true).fadeIn(350);
  }, function() {
    $(this).children('.play-button-wrapper').stop(true,true).fadeOut(350);
  });

  $('.thumb').click(function(){
    var data = videos[$(this).attr('rel')];
    var player = "http://player.vimeo.com/video/"+data['id'];
    var frame = $('<iframe id="videoPlayer" width="640" height="360" frameborder="0">');
    frame.attr('href', player);
    $('#videoPlayer').append(frame);
    $('#modal').fadeIn(250);
  });

});

function sendMail(_message,_from) {
  var to = "";
  var subject = "Email from rawmedian.com";
  $.ajax({
    type: 'POST',
    url: 'http://betterthanmediocre.com/mailers/generic_mailer.php',
    data: {to: to, subject: subject, message: _message, from: _from},
    success: function() {
        $('#sendMessage').val('Message Sent').css('background-color', '#0F0');
    },
    error: function() {
        alert('There was a problem sending your message. Please try again later or email us directly at '+to);
    }
  });
}

function goToByScroll(_id) {
  $('html,body').animate({scrollTop: $(_id).offset().top},'slow');
}

var timer_going = false;
function checkIndex() {
  if(!timer_going) {
    var t = setTimeout(verifyPosition,1000);
    timer_going = true;
  }
}

function verifyPosition() {
  var top = $(this).scrollTop();
  $.each(pages, function(i, item) {
    var offset = $(item).offset().top;
    // console.log(top, offset, top+window_size);
    if(offset >= top && offset < top + window_size){
      $('#mainNav .anchored').removeClass('active');
      $('#mainNav .anchored').eq(i).addClass('active');
    }
  });
  timer_going = false;
}

