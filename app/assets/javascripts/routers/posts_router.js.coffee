class Impel.Routers.Posts extends Backbone.Router
  routes:
    '': 'index'
    'posts/:id': 'show'

  initialize: ->
    @collection = new Impel.Collections.Posts()
    @collection.fetch()

  index: ->
    view = new Impel.Views.PostsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "show page for id #{id}"
