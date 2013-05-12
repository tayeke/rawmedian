class App
  constructor: (_options = {}) ->
    @[key] = val for key, val of _options 
    @mailsent = false
    FB.init
      appId: @fbid
      xfbml: true 
      status: false                                 
  init: =>
    # globalized dom ready here

    # banner 
    @$slides = $('.featuring img')
    @total_slides = @$slides.length
    @current_slide = 1
    # start slideshow timer
    if @total_slides
      @$slides.eq(@current_slide-1).fadeIn(1200)
      clearInterval @slideTimer
      @slideTimer = setInterval @nextSlide, 12000

    # share button listener
    $('.fb-share-btn').click @shareClick

    # contact form
    $('#contactForm').submit (e) =>
      e.preventDefault();
      message = $('textarea[name="message"]').val();
      email = $('input[name="from"]').val();
      if message.length > 20
        @sendMail message,email
      else
        alert 'We require a longer message, keep typing.'

  sendMail: (message, from) =>
    unless @mailsent
      @mailsent = true
      to = "contact@rawmedian.com"
      subject = "Email from rawmedian.com"
      $.ajax
        type: 'POST'
        url: '/send_mail'
        data: 
          to: to
          subject: subject
          message: message
          from: from
        success: ->
            alert 'Message Sent'
        error: ->
            alert 'There was a problem sending your message. Please try again later or email us directly at '+to

  nextSlide: =>
    @$slides.eq(@current_slide-1).fadeOut(1200)
    @current_slide = if @current_slide is @total_slides then 1 else @current_slide + 1
    @$slides.eq(@current_slide-1).fadeIn(1200)

  shareClick: (e) ->
    e.preventDefault()
    $item = $(@)
    FB.ui
      method: 'feed'
      link: $item.data('link')

@app = new App(globals) unless @app

$(app.init)

    
