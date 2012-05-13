exports.actions = (req, res, ss) ->
  req.use('session')
  
  room_data: (room_s) ->
    console.log "TODO room_data server", room_s
    res
      users: []
      video: ""
