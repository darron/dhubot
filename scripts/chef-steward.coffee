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
inspect = require('util').inspect

steward_url = process.env.HUBOT_STEWARD_URL

module.exports = (robot) ->

  logger = robot.logger
  logger.debug(inspect steward_url)

  robot.respond /chef status/i, (msg) ->
    msg.http(steward_url)
      .get() (err, res, body) ->
        res.end body
