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

module.exports = (robot) ->

steward_url = process.env.HUBOT_STEWARD_URL

  robot.respond /chef status/i, (msg) ->
    msg.http(steward_url)
      .get() (err, res, body) ->
        res.end body
