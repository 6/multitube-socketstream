# This file automatically gets called first by SocketStream and must always exist

# Make 'ss' available to all modules and the browser console
window.ss = require('socketstream')
window.room_s = window.location.pathname.split("?")[0].substring(1)
window.room_s = null if $.trim(window.room_s) is ""

ss.server.on 'disconnect', ->
  console.log('Connection down :-(')

ss.server.on 'reconnect', ->
  console.log('Connection back up :-)')

ss.server.on 'ready', ->

  # Wait for the DOM to finish loading
  jQuery ->
    
    # Load app
    require('/app')
    
    return unless room_s?
    
    $("#yt-form").show(0)
    $("#room-name").val(room_s)
