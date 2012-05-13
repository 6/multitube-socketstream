$ = require("jquery")

parse_room = (room_s) ->
  room_s = $.trim(room_s)
  if room_s is "" then null else room_s

exports.actions = (req, res, ss) ->
  req.use('session')
  
  join_room: (room_s) ->
    room_s = parse_room(room_s)
    return unless room_s?
    req.session.channel.reset()
    req.session.channel.subscribe(room_s)
    console.log "TODO room_data server", room_s
    res
      users: []
      video: ""

  #TODO get room_s from session
  send_video: (room_s, yt_id) ->
    room_s = parse_room(room_s)
    return unless room_s? and yt_id.match(/^[-_a-z0-9]+$/i)
    ss.publish.channel(room_s, 'receive_video', yt_id)
  
  #TODO get room_s from session
  send_seek_to: (room_s, sec) ->
    room_s = parse_room(room_s)
    sec = parseInt(sec)
    return unless room_s? and sec >= 0
    ss.publish.channel(room_s, 'receive_seek_to', sec)
