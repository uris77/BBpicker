@Backpicker.module "Backpicker.Views", (Views, App, Backbone, Marionette, $, _) ->
  class Views.Filepicker extends Marionette.ItemView
    template: JST['templates/placeholder.hb']
    id: Math.ceil(_.random(10, 1009)).toString(36)

    initialize: (callback, context, options={}) ->
      @_setClassName(options.className)
      @_img = options.imageUrl
      @_callback = callback
      @_context = context
      @_args = options.args
      if options.width
        @_width = options.width
      if options.height
        @_height = options.height
      if options.maxSize
        @_maxSize = options.maxSize

    _setClassName: (className) ->
      if className
        @className = className
        @$el.addClass @className

    logoImg: (img) ->
      "<img src=#{img} alt='Image' />"

    _showImg: (img) ->
      $("##{@id}").html('')
      $("##{@id}").append @logoImg(img)

    _filepickerOptions: =>
      multiple: false,
      dragEnter: =>
        $("##{@id}").html("Drop to upload").css(
          'backgroundColor': "#E0E0E0"
          'border': "1px solid #000"
          'height': "100px"
        )
      dragLeave: =>
        $("##{@id}").html("Drop files here").css(
          'backgroundColor': "#F6F6F6"
          'border': "1px dashed #666"
          'height': "100px"
        )

      onSuccess: (InkBlobs) =>
        $("##{@id}").text("Done, see result below")
        $("##{@id}").html('')
        if @_args
          @_args['fileBlob'] = InkBlobs[0]
        else
          @_args['fileBlob'] = [InkBlobs[0]]
        @_showImg(InkBlobs[0].url)
        App.execute "bbpicker:success", @_callback, @_context, [@_args]

      onError: (type, message) ->
        console.error "#{type} ", message
        App.vent.trigger "bbpicker:error", {type: type, message: message}

      onProgress: (percentage) =>
        $("##{@id}").html('')
        console.info "Uploading #{percentage}%"
        $("##{@id}").text("Uploading (#{percentage}%)")

    onShow: ->
      if @_img
        $("##{@id}").html('')
        $("##{@id}").append @logoImg(@_img)
      options = @_filepickerOptions()
      if @_width
        options.width = @_width
      if @_height
        options.height = @_height
      if @_maxSize
        options.maxSize = @_maxSize
      filepicker.makeDropPane($("##{@id}"), options)

  Views.getView = (callback, context, options) ->
    new Views.Filepicker(callback, context, options)
