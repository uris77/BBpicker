@Backpicker = do(Backbone, Marionette) ->
  class BackpickerApp extends Marionette.Application
    show: (callback) ->
      console.log "got callbacK ", callback
      viewModule = @module('Backpicker.Views')
      view = viewModule.getView()
      view

  App = new BackpickerApp()
  App

@Backpicker.module "Backpicker.Views", (Views, App, Backbone, Marionette, $, _) ->
  class Views.Filepicker extends Marionette.ItemView
    template: JST['templates/logo.hb']

  Views.getView = -> new Views.Filepicker()

Backpicker.start()

describe "image placeholder", ->
  beforeEach: ->
    affix '#placeholder'

  describe "rendering", ->
    Given ->
      @callback = -> "callback"
    When ->
      $('#placeholder').append(Backpicker.show(@callback).el)
    Then ->
      expect($('#placeholder')).not.toBeNull()
