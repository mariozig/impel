class Impel.Collections.Posts extends Backbone.PageableCollection

  model: Impel.Models.Post

  url: '/api/posts'

  mode: 'server'

  state:
    firstPage: 1
    currentPage: 1

  queryParams:
    currentPage: "page"

  parseState: (resp, queryParams, state) ->
    totalRecords: resp.total_records

  parseRecords: (resp) ->
    resp.entries

