Platform = require './platform.coffee'
Player = require './player.coffee'

module.exports =
  create: (world, level) ->
    Platform.setWorld world
    Player.setWorld world
    level world, Player, Platform