$ = require("jquery")

exports.actions = (req, res, ss) ->
  req.use('session')
  
  join_room: (room_s) ->
    room_s = $.trim(room_s)
    return unless room_s?
    req.session.channel.reset()
    req.session.channel.subscribe(room_s)
    console.log "TODO room_data server", room_s
    res
      users: []
      video: ""

  send_video: (room_s, yt_id) ->
    room_s = $.trim(room_s)
    return unless room_s? and yt_id.match(/^[-_a-z0-9]+$/i)
    ss.publish.channel(room_s, 'receive_video', yt_id)
