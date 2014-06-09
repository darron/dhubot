checkdns = require('checkdns');

module.exports = (robot) ->
  robot.respond /lookup (.*)$/i, (msg) ->
    msg.send "#{msg.match[1]}: #{checkdns.nslookup(msg.match[1], 'A');}"
