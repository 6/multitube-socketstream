current_yt_id = undefined
ytplayer = undefined

# This function is automatically called by the player once it loads
window.onYouTubePlayerReady = (player_id) ->
  ytplayer = document.getElementById("ytPlayer")
  ytplayer.setVolume(50)


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
  current_yt_id = yt_id
  ytplayer.loadVideoById(yt_id)

yt_id_from_url = (url) ->
  match = /(?:youtube.com\/watch\?[^\s]*v=|youtu.be\/)([-_\w]+)/.exec url
  if match? then match[1] else null
