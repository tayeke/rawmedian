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
    var player = "http://player.vimeo.com/video/"+data['id']+"?autoplay=1&amp;portrait=0&amp;byline=0&amp;title=0&amp;color=006699";
    var frame = $('<iframe width="720" height="405" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>');
    frame.attr('src', player);
    $('#videoPlayer').append(frame);
    $('#videoInfo h4').html(data['title']);
    $('#videoInfo p.description').html(data['description']);

    //social stuff
    var social = $('<div id="socialBtns"></div>');
    social.append($('<div class="fb-like" data-href="http://rawmedian.com/vid/'+data['id']+'" data-send="false" data-layout="button_count" data-width="50" data-show-faces="false" data-colorscheme="dark"></div>'));
    social.append($('<div class="g-plusone" data-href="http://rawmedian.com/vid/'+data['id']+'"></div>'));
    $('#videoPlayer').append(social);
    $('#modal').fadeIn(250, function() {
      FB.XFBML.parse();
      gapi.plusone.go();
    });
  });

  $(document).keyup(function(e){
      if(e.which == 27){
          closeModal();
      }
  });

  $(document).click(function(e) {
    if (e.target == $('#modal')[0]) {
      closeModal();
    }
  });

  if(vid_id) {
    $('#'+vid_id).click();
  }

});

function closeModal() {
  $('#modal').fadeOut(200, function() {
    $('#videoPlayer').html('');
  });
}

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

