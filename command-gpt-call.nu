{
  modules: {
    "anthropic": (.head gpt.mod.provider.anthropic | .cas $in.hash)
  }

  run: {|frame|
    let message = .cas $frame.hash
    let key = .head gpt.provider | .cas $in.hash | from json | get key
    let p = anthropic provider 
    do $p.prepare-request {messages: [{role: "user" content: [{type: "text" text: $message}]}]} | do $p.call $key "claude-sonnet-4-20250514" | do $p.response_stream_aggregate 
  }
}
