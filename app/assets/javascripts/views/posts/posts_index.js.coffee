class Impel.Views.PostsIndex extends Backbone.View

  template: JST['posts/index']

  initialize: ->
    @collection.on('sync', @render, @)

  render: ->
    @$el.html @template(posts: @collection)
    @