class Impel.Views.Post extends Backbone.View

  template: JST['posts/post']

  attributes:
    class: 'post'

  render: ->
    @$el.html @template(post: @model)
    @