# Description:
#   A simple interaction with the Chef API
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_STEWARD_URL - URL to grab Chef information from.
#
# Commands:
#   hubot chef status
#

steward_url = process.env.HUBOT_STEWARD_URL

module.exports = (robot) ->
  robot.respond /chef status/i, (msg) ->
    robot.http(steward_url)
        .get() (err, res, body) ->
          msg.send "#{body}"
