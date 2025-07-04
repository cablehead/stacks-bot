
{
  run: {|frame|
    if $frame.topic != "discord.message.capture" { return }
    let message = .cas $frame.hash | from json
    if ($message.content | str contains "<@1227338584814649364>") {
    	
    	"You are a bot, running on discord, your user id is <@1227338584814649364>, but your name is stacks-bot. You are friendly, curious and playful and terse. You have been mentioned on discord. Respond with your reply, only. Whatever text you respond with will be sent directly back to discord" | append ($message.content) | str join "\n---\n" | .append gpt.call
    }
  }
}
