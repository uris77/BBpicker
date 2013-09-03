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

    _setClassName: (className) ->
      if className
        @className = className
        @$el.addClass @className

    logoImg: (img) ->
      "<img src=#{img} alt='Image' width='50%' height='50%'/>"

    _showImg: (img) ->
      $("##{@id}").html('')
      $("##{@id}").append @logoImg(img)

    onShow: ->
      if @_img
        $("##{@id}").html('')
        $("##{@id}").append @logoImg(@_img)

      filepicker.makeDropPane($("##{@id}"),
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

        onProgress: (percentage) =>
          $("##{@id}").html('')
          console.info "Uploading #{percentage}%"
          $("##{@id}").text("Uploading (#{percentage}%)")
      )

  Views.getView = (callback, context, options)-> new Views.Filepicker(callback, context, options)
