var checkdns = require('checkdns');

module.exports = (robot) ->
  robot.respond /lookup (.*)$/i, (msg) ->
    msg.send "Will lookup: #{msg.match[1]}"
