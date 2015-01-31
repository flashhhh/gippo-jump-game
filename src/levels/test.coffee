module.exports = (world, Player, Platform) ->
  Platform.spawn 500, 590, 2000, 10
  Platform.spawn 500, 430, 90, 60
  Platform.spawn 900, 430, 90, 360

  Player.spawn 500, 301
