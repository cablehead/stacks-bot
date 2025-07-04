{
  run: {|frame|
    if $frame.topic != "discord.ws.recv" { return }

    let message = .cas $frame.hash | from json
    if $message.t? != "MESSAGE_CREATE" { return }

    $message | get d | select author channel_id channel_type content | update author { $in.id }
  }

   return_options: {
    suffix: ".capture" # Output topic suffix
  }
}
