@Backpicker = do(Backbone, Marionette) ->
  class BackpickerApp extends Marionette.Application
    show: (callback, context, options={}) ->
      viewModule = @module('Backpicker.Views')
      view = viewModule.getView(callback, context, options)
      view

  App = new BackpickerApp()
  App.addInitializer ->
    App.commands.setHandler 'bbpicker:success', (callback, context, args) ->
      callback.apply context, args
  App
