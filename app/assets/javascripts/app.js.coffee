class App
  constructor: (_options = {}) ->
    @[key] = val for key, val of _options 
  init: ->
    # globalized dom ready here
    

@app = new App(globals)

$(app.init)

    
