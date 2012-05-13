current_yt_id = undefined
ytplayer = undefined
start_at = 0

# have to attach to window so JS API can call it
window.player_state_change = (state) ->
  if state is 1 # playing, duration is now available
    ytplayer.getDuration()
    $("#seek-slider").slider("option", "max", Math.floor(ytplayer.getDuration()))

# This function is automatically called by the player once it loads
window.onYouTubePlayerReady = (player_id) ->
  ytplayer = document.getElementById("ytPlayer")
  ytplayer.addEventListener("onStateChange", "player_state_change")
  ytplayer.setVolume(50)

ss.event.on "receive_video", (yt_id) ->
  current_yt_id = yt_id
  ytplayer.cueVideoById(yt_id)
  seek_to(start_at) if start_at != 0
  ytplayer.playVideo()

ss.event.on "receive_seek_to", (sec) ->
  seek_to(sec)
  ytplayer.playVideo()

$("#seek-slider").slider
  range: "min"
  min: 0
  max: 100
  value: start_at
  slide: (e, ui) =>
    ss.rpc('app.send_seek_to', room_s, ui.value)

$("#room-form").submit (e) ->
  e.preventDefault()
  new_room = $.trim($("#room-name").val())
  if new_room? and new_room isnt room_s
    #TODO use pushState or just location.hash
    window.location.href = "#{window.location.origin}/#{new_room}"

$("#yt-form").submit (e) ->
  e.preventDefault()
  yt_id = yt_id_from_url($("#yt-link").val())
  return alert("That doesn't appear to be a valid YouTube link") unless yt_id?
  return alert("That video is currently playing") if current_yt_id is yt_id
  ss.rpc('app.send_video', window.room_s, yt_id)

seek_to = (sec) ->
  if ytplayer?
    ytplayer.seekTo(sec)
    $("#seek-slider").slider('value', sec)
    start_at = 0
  else
    start_at = sec

yt_id_from_url = (url) ->
  match = /(?:youtube.com\/watch\?[^\s]*v=|youtu.be\/)([-_\w]+)/.exec url
  if match? then match[1] else null
