dns = require('dns');

module.exports = (robot) ->
  robot.respond /lookup (.*)$/i, (msg) ->
    msg.send "#{msg.match[1]}: #{dns.resolve4(msg.match[1]);}"
