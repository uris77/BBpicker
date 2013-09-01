Backpicker.start()

describe "Backpicker", ->
  beforeEach ->
    @container = affix '#placeholder'
    @callback = -> console.log "Call back called"
    @view = Backpicker.show({className: 'cssClassName'})

  describe "renders message in placeholder", ->
    When ->
      @result = @container.append(@view.render().el)
    Then ->
      expect(@container.children().length).toBe(1)
      expect($('#placeholder').children()[0].innerText).toBe('Drag Image Here!')

  describe "assigns css class to placeholder", ->
    When ->
      @result = @container.append(@view.render().el)
    Then ->
      expect(@container.children().length).toBe(1)
      expect(@container.children()[0].className).toBe('cssClassName')

  describe "placeholder assigned a random id", ->
    When ->
      @result = @container.append(@view.render().el)
    Then ->
      expect(@container.children()[0].id).not.toBe('')

  describe "callback is executed", ->
    Given ->
      spyOn(@callback, 'apply')
    When ->
      Backpicker.execute "bbpicker:success", @callback, @, ["An InkBlob"]
    Then ->
      expect(@callback.apply).toHaveBeenCalled()
