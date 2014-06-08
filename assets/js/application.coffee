Array.prototype.find = (attrs) ->
  result = null
  @some((value, index, list) ->
    if value is attrs
      result = value
      return true
    for key of attrs
      if attrs[key] isnt value[key]
        return false
    result = value
    return true
  )
  return result


Application = ->
  @init()
  @

Application.prototype.init = ->
  console.log('Booting up application.')
  @refreshConfig()
  @bindInputs()
  @boards = []
  @lists = []
  @

Application.prototype.refreshConfig = ->
  console.log('Refreshing configuration.')
  Trello.authorize(
    type: 'popup'
    name: 'TrelloPost'
    persist: true
    interactive: true
    expiration: 'never'
    scope:
      read: true
      write: true
    success: (data) =>
      console.log "bum2"
      @fetchBoards()
    error: (err) =>
      # If the autorization failed, delete the token and try to init again.
      Trello.deauthorize()
      @init()
  )
  @

Application.prototype.inputSuccess = (name) ->
  $(name).next().remove()
  $(name).after('<span class="glyphicon glyphicon-ok form-control-feedback"></span>')

Application.prototype.inputFail = (name) ->
  $(name).next().remove()
  $(name).after('<span class="glyphicon glyphicon-remove form-control-feedback"></span>')

Application.prototype.bindInputs = ->
  $('#board').blur(() =>
    selectedBoard = $('#board').val()
    board = @findBoardFromName(selectedBoard)
    if board
      @fetchLists(board.id)
    else
      @inputFail('#board')
      $('#list').val('')

  )
  $('#list').blur(() =>
    selectedList = $('#list').val()
    list = @findListFromName(selectedList)
    if list
      @inputSuccess('#list')
    else
      @inputFail('#list')
  )

Application.prototype.fetchBoards = ->
  Trello.get("/members/me/boards",{ fields: "name" }, (data) =>
    @boards = data
    @onBoardsFetched()
  , (err) =>
      # If the fetching failed, delete the token and try to init again.
      Trello.deauthorize()
      @init()
  )

Application.prototype.fetchLists = (identifier) ->
  Trello.get("/boards/" + identifier + "/lists", {fields: 'name'}, (data) =>
    @lists = data
    @onListsFetched()
  , (err) ->
    console.log err
    @inputFail('#board')
  )

# TODO: Use jQuery on/trigger mecanism
Application.prototype.onBoardsFetched = ->
  boards = $.map(@boards, (item) ->
    return item.name
  )
  $('#board').inlineComplete({ terms: boards })

# TODO: Use jQuery on/trigger mecanism
Application.prototype.onListsFetched = ->
  lists = $.map(@lists, (item) ->
    return item.name
  )
  $('#list').inlineComplete({ terms: lists })
  @inputSuccess('#board')

Application.prototype.findBoardFromName = (name) ->
  return @boards.find({ 'name': name })

Application.prototype.findListFromName = (name) ->
  return @lists.find({ 'name': name })

Application.prototype.submitIssue = (list, description) ->
  console.log('Submitting new card')

  if list is null
    console.error('Cannot submit issue with no list')
    return

  identifier = list.id
  console.log identifier

  $('#pin').addClass('hidden')
  $('#loading').removeClass('hidden')

  Trello.post("/lists/" + identifier + "/cards", {name: description}, (data) =>
    console.log('Issue successfully submitted!')

    if event.keyCode == 27 and in_node_webkit
      gui.Window.get().show()

    $('#loading').addClass('hidden')
    $('#pin').removeClass('hidden')
  , (err) ->
    console.error('There was an error while submitting the issue')
    $('#message').addClass('alert alert-danger').html('Error T_T')
    $('#loading').addClass('hidden')
    $('#pin').removeClass('hidden')
    console.log err
  )

$('document').ready(() ->
  $('#board').focus()

  application = new Application()

  $('#main-form').submit((event) =>
    event.preventDefault()

    list = application.findListFromName($('#list').val())
    description = $('#description').val()
    application.submitIssue(list, description)
  )

  # cmd + enter = submit
  $('form').keydown((event) ->
    windowsCommand = event.keyCode is 13 and event.ctrlKey
    macCommand = event.keyCode is 13 and event.metaKey
    if (windowsCommand or macCommand)
      $(@).submit()
      return false
  )

  # esc
  $(window).keydown((event) ->
    if (event.keyCode is 27)
      gui.Window.get().hide()
  )
)
