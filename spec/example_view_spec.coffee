@Backpicker = do(Backbone, Marionette) ->
  class BackpickerApp extends Marionette.Application
    show: (callback, context, options={}) ->
      callback.apply context
      viewModule = @module('Backpicker.Views')
      view = viewModule.getView(options)
      view

  App = new BackpickerApp()
  App

@Backpicker.module "Backpicker.Views", (Views, App, Backbone, Marionette, $, _) ->
  class Views.Filepicker extends Marionette.ItemView
    template: JST['templates/placeholder.hb']
    id: Math.random(32).toString(36)

    initialize: (options={}) ->
      @_setClassName(options.className)

    _setClassName: (className) ->
      if className
        @className = className

  Views.getView = (options)-> new Views.Filepicker(options)

Backpicker.start()

describe "Backpicker", ->
  beforeEach ->
    @container = affix '#placeholder'
    @callback = -> console.log "Call back called"

  describe "renders message in placeholder", ->
    When ->
      @result = @container.append(Backpicker.show(@callback, @).render().el)
    Then ->
      expect(@container.children().length).toBe(1)
      expect($('#placeholder').children()[0].innerText).toBe('Drag Image Here!')

  describe "assigns css class to placeholder", ->
    When ->
      view = Backpicker.show(@callback, @, {className: 'cssClassName'})
      @result = @container.append(view.render().el)
    Then ->
      expect(@container.children().length).toBe(1)
      expect(@container.children()[0].className).toBe('cssClassName')

  describe "placeholder assigned a random id", ->
    When ->
      view = Backpicker.show(@callback, @)
      @result = @container.append(view.render().el)
    Then ->
      expect(@container.children()[0].id).not.toBe('')
