window.PIXI = require '../lib/pixi.min'
window.Physics = require '../lib/physicsjs-full.min'
configure = require './game.configure.coffee'

levelCreator = require './levelCreator.coffee'
levelTest = require './levels/test.coffee'
levelString = require './levels/string.coffee'

Physics (world) ->
  configure world
  levelCreator.create world, levelString
  Physics.util.ticker.start()
