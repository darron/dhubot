#
# Copyright 2012 Mortar Data Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# AWS status rss reader
#
# Publish a message in campfire whenever AWS publishes a new status update.
#
# Will only post each message once and will never post messages that are older than 1 hour.

fs = require('fs')
feedparser = require('feedparser');

room = process.env.HUBOT_HIPCHAT_ROOMS

last_check_time = 0
oldest_date_to_post = (new Date()).getTime() - (60 * 60 * 1000)
poll_interval = 60 * 1000

get_callback = (robot, user) ->
    parser_callback = (error, meta, articles) ->
        if error
            console.error(error)
        else
            now = (new Date()).getTime()
            for article in articles
                pubDate = Date.parse(article['pubdate'])
                if (pubDate - last_check_time) >= 0 and (pubDate - oldest_date_to_post) >= 0
                    message = "@uhOh - #{article.guid} - #{article.title} \n #{article.description}"
                    robot.send user, message
            last_check_time = now
    return parser_callback

checkStatus = (robot) ->
    user = robot.userForId 'AWS Status'
    user.room = room
    out = feedparser.parseUrl("http://status.aws.amazon.com/rss/all.rss", get_callback(robot, user))

module.exports = (robot) ->
    setInterval(checkStatus, poll_interval, robot)
