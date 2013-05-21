class Impel.Views.PostsIndex extends Backbone.View

  template: JST['posts/index']

  initialize: ->
    @collection.on('sync', @render, @)

  render: ->
    @$el.html @template()
    @collection.each(@appendPost)
    # paginator = new Impel.Views.PostsIndex(collection: @collection)
    # @$el.append

    # $('#posts').isotope
    #   itemSelector: ".post"
    @

  appendPost: (post) ->
    view = new Impel.Views.Post(model: post)
    $('#posts').append(view.render().el)