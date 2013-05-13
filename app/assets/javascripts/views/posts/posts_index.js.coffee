class Impel.Views.PostsIndex extends Backbone.View

  template: JST['posts/index']

  initialize: ->
    @collection.on('sync', @render, @)

  render: ->
    @$el.html @template()
    @collection.each(@appendPost)
    $('#posts').isotope
      itemSelector: ".post"
    @

  appendPost: (post) ->
    view = new Impel.Views.Post(model: post)
    $('#posts').append(view.render().el)