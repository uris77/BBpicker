@Backpicker.module "Backpicker.Views", (Views, App, Backbone, Marionette, $, _) ->
  class Views.Filepicker extends Marionette.ItemView
    template: JST['templates/placeholder.hb']
    id: Math.random(32).toString(36)

    initialize: (callback, context, options={}) ->
      @_setClassName(options.className)
      @_img = options.imageUrl
      @_callback = callback
      @_context = context
      @_args = options.args

    _setClassName: (className) ->
      if className
        @className = className

    logoImg: (img) ->
      "<img src=#{img} alt='Image'/>"

    onShow: ->
      if @_img
        $("##{@id}").html('')
        $("##{@id}").append @logoImg(@_img)

      filepicker.makeDropPane($("##{@id}")[0],
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
            @_args.push InkBlobs[0]
          else
            @_args = [InkBlobs[0]]
          App.execute "bbpicker:success", callback, context, @_args

        onError: (type, message) ->
          console.error "#{type} ", message

        onProgress: (percentage) =>
          $("##{@id}").html('')
          console.info "Uploading #{percentage}%"
          $("##{@id}").text("Uploading (#{percentage}%)")
      )

  Views.getView = (callback, context, options)-> new Views.Filepicker(callback, context, options)
