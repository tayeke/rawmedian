class App
  constructor: (_options = {}) ->
    @[key] = val for key, val of _options 
    FB.init
      appId: @fbid
      xfbml: true                                  
  init: =>
    # globalized dom ready here

    # banner 
    @$slides = $('.featuring img')
    @total_slides = @$slides.length
    @current_slide = 1
    # start slideshow timer
    if @total_slides
      @$slides.eq(@current_slide-1).fadeIn(1200)
      setInterval @nextSlide, 12000

    #share button listener
    $('.fb-share-btn').click @shareClick

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

@app = new App(globals)

$(app.init)

    
