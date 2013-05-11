window.Impel =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Impel.Routers.Posts
    Backbone.history.start()

$(document).ready ->
  Impel.initialize()
