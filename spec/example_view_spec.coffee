@Backpicker = do(Backbone, Marionette) ->
  class BackpickerApp extends Marionette.Application
    show: (callback, options) ->
      console.log "got callbacK ", callback
      viewModule = @module('Backpicker.Views')
      view = viewModule.getView(options)
      view

  App = new BackpickerApp()
  App

@Backpicker.module "Backpicker.Views", (Views, App, Backbone, Marionette, $, _) ->
  class Views.Filepicker extends Marionette.ItemView
    template: JST['templates/logo.hb']

    initialize: (options={}) ->
      @setClassName(options.className)

    setClassName: (className) ->
      if className
        @className = className

  Views.getView = (options)-> new Views.Filepicker(options)

Backpicker.start()

describe "Backpicker", ->
  beforeEach ->
    @container = affix '#placeholder'

  describe "renders message in placeholder", ->
    Given ->
      @callback = -> "callback"
    When ->
      @result = @container.append(Backpicker.show(@callback).render().el)
    Then ->
      expect(@container.children().length).toBe(1)
      expect($('#placeholder').children()[0].innerText).toBe('Drag Image Here!')

  describe "assigns css class to placeholder", ->
    Given ->
      @callback = -> "callback"
    When ->
      view = Backpicker.show(@callback, {className: 'cssClassName'})
      @result = @container.append(view.render().el)

    Then ->
      expect(@container.children().length).toBe(1)
      expect(@container.children()[0].className).toBe('cssClassName')
