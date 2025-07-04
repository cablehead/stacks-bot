$env.BOT_TOKEN = .head discord.ws.token | .cas $in.hash

{
  modules: {discord: (.head discord.nu | .cas $in.hash)}

  run: {|frame|
    if $frame.topic != "gpt.response" { return }

    # TODO: .cas should also be able to take a record, to match xs2.nu's usage
    let message = $frame | .cas $in.hash | from json | get message

    let trigger = .get $frame.meta.frame_id | .get $in.meta.frame_id | .cas $in.hash | from json

    let content = $message | get content.0.text

       {
        content: $content
        message_reference: { message_id: $trigger.id }
      } | discord channel message create $trigger.channel_id
  }
}
