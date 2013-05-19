class Impel.Collections.Posts extends Backbone.PageableCollection

  model: Impel.Models.Post

  url: '/api/posts'

  mode: 'server'

  parseState: (resp, queryParams, state) ->
    totalRecords: resp.total_records

  parseRecords: (resp) ->
    resp.entries

